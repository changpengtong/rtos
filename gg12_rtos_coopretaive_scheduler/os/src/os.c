/*
 * @file os.c
 */

#include <stdint.h>

#define MAX_THREAD_NUM				10
#define THREAD_STACK_SIZE			128

typedef uint32_t* stack_pt_t;

typedef enum {
	thread_ready,
	thread_running,
	thread_dead
} thread_status_t;

typedef struct tcb_t{
	int id;
	uint32_t* stack_pt;
	thread_status_t status;
	struct tcb_t* next;
	struct tcb_t* prev;
} tcb_t;

tcb_t* running_thread;

static tcb_t thread_table[MAX_THREAD_NUM];

static uint32_t stack_table[MAX_THREAD_NUM][THREAD_STACK_SIZE];

void thread_table_init(void) {
	for (int i = 0; i < MAX_THREAD_NUM; i++) {
		thread_table[i].id = i;
		thread_table[i].status = thread_dead;
	}
}

void os_init (void) {
	thread_table_init();
	running_thread = &thread_table[0];
	running_thread->prev = running_thread;
	running_thread->next = running_thread;
}

stack_pt_t thread_stack_init(int thread_index) {
	stack_table[thread_index][114] = 0xF0F0F0F0;
	stack_table[thread_index][115] = 0xD0D0D0D0;
	stack_table[thread_index][116] = 0xC0C0C0C0;
	stack_table[thread_index][117] = 0xB0B0B0B0;
	stack_table[thread_index][118] = 0xA0A0A0A0;
	stack_table[thread_index][119] = 0x90909090;
	stack_table[thread_index][120] = 0x80808080;
	stack_table[thread_index][121] = 0x70707070;
	stack_table[thread_index][122] = 0x60606060;
	stack_table[thread_index][123] = 0x50505050;
	stack_table[thread_index][124] = 0x40401010;
	stack_table[thread_index][125] = 0x30303030;
	stack_table[thread_index][126] = 0x20202020;
	stack_table[thread_index][127] = 0x10101010;
	return &stack_table[thread_index][114];
}


void os_add(void (*task)(void)) {

	for (int i = 0; i < MAX_THREAD_NUM; i++) {
		if (thread_table[i].status == thread_dead) {
			thread_table[i].stack_pt = thread_stack_init(i);
			thread_table[i].stack_pt[0] = (uint32_t) task;
			thread_table[i].status = thread_ready;

			tcb_t* new_thread = &thread_table[i];
			tcb_t* tail = running_thread->prev;
			new_thread->prev = tail;
			new_thread->next = running_thread;
			tail->next = new_thread;
			running_thread->prev = new_thread;
			break;
		}
	}

	running_thread = &thread_table[0];

}


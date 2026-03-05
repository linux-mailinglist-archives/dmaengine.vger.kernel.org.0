Return-Path: <dmaengine+bounces-9284-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJYbLi3MqWl+FQEAu9opvQ
	(envelope-from <dmaengine+bounces-9284-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 19:32:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8A0216FC3
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 19:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C46F83024457
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324A83A257F;
	Thu,  5 Mar 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coNaFCJM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E233A1E84
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735531; cv=none; b=gCY4K6oJCBYf2tnKmCmB0qDnoMFg+TStQmr63VQMN8t2bT26S7nFfiU2UyzOiqASP6C9LXoiNWhfHaTJn29bUBlqDJpb/yPG3/heIXXV+dxItcx6TcUXkNGkIGXIqub8MsH1hbaDIm9xd78Es7yhof/XHRGPG4m8KkdKrji3occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735531; c=relaxed/simple;
	bh=jwU0Ew28RtvnakAaPXGciALX0RTqLvirOkWFJZjvaew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ehwjxz24J30z/0Px+yNN0N44zli+caxMTDOE4RtPFgTCTWDNgHVQGluRQ99Cbh13WHUF+8wfDVTZmZWk3990H4awCz8cePX+k4LiKmK7LsRAs0BMFuHRs0r1EpeTOvvx75Yt95C9FqIrXsL0dMLhkf8VloIMujwfxpFO+q0qZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coNaFCJM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-480706554beso91058485e9.1
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772735528; x=1773340328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqlFsmrJ38u/W/7trXv1PzOYBqgbdqFuM/Eo+xaXSxo=;
        b=coNaFCJMhTcziM998Pi2alJVvzHuoci88CWBhgaIZd3oX2X3MgO3RzHI5XbubuKnET
         CI0DtmFyMSbDqvMRRJ893oFMhVaoz7xjJGlF5Qy8X18gbR6bxZAfQxWwgiyaf+aKzUqs
         +fw7Bs2NdXPQUl5j2CGxOjQmyxIFIGD2bc7Q7Q30cB9EHazpNgvpp0YKNfAuzjvjJE7a
         a+2brQnjQ2MP84rzIJG7jY8Tqi7AhtxD3stSD/V2Dd28eTr3QomAkGsSxfmXcX1yrAOS
         /f3NvIw3mYOlM0WBADRAUYqdJbkdOHAWmqYoNiyNnqXLp0X9kKitbagyET/14J3GgPiQ
         KSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735528; x=1773340328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqlFsmrJ38u/W/7trXv1PzOYBqgbdqFuM/Eo+xaXSxo=;
        b=dosnEh5cmV7dIwmNZ5FEKeIaSwkUJDKjhhJFjMV9azUxWdh7zNCAqLnpEasXHwc38u
         Z1o+UlskrEU9jfMeGXhxBMUxbsE9Shwhq0mcBAx2sHPeX/3a3Bx5YH/nksb8bn0Umd1+
         qACXpvlSFFseQHixdCFpfFYLFxPXhSlsgxjiA8QCF6cWPtXRGo6OmDlAI6xxSBhi3NKH
         g6lX/m/FPyQlaMwcgnadZh24wzoHvMTFJeBeO8ULjDaM9nABSLPRCnJNAjAZDY5Y5rFb
         tJuRWlRgJSZ3Z0J+kQK0Ek2OECySBeeLwDqC+3zIqGamrEB7ILww4BBWbHRx42J9U3Hi
         4YvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD078L3I7BPxynAygm5qeFCq17bIT0QfyPbdBbFv2vICa0lo4teR7xXmJqihr+g1Rksn8/LV4jCio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyREHgQnn49huCMX3qM5BxxvcSzgBRCXpW9S0LhcrjsVTb7T8
	g9yX7Vq2+y40QMehZDifxgaPoJ2Z8ch5ehVw1mR6vV2tjY8LjkIK5FdT
X-Gm-Gg: ATEYQzwbOvMqB/C33yrVjtNI5cmccbfcxcpuBwAdCC2zcV21PEGVMfUjWHA4sMRb9xF
	Z/FLixWPT4GUBr7Wnmq2RrrD9dT3DJpyZYfu8y000t5YALpb3XXVZYSbysQgt786F7aZWT/W8AH
	lgDcFVj5Auv/d3u2CrRokZL/EDYCP2DGULwqj1weyA2qT3KAmIl/W8mOeoHOjhRgRE+cK9+WSNu
	AmV4FDDZyIJcWx84fUIss8FiYR3HjqezlR7vZ1pUw5uEL4Zc0peEcUQIIwTy/It7+/5EvuFXKMV
	c3n/r9mcjRVXxyF2K4tg4rIwaNRj6pXBT9PTUIB4C2DwdL8VJfAKgDK9JhB8Ngog2HcoUwMzUGQ
	4zlP8g6QCJEdwscWtktDwbEkLGvHNgjsj7uNkGhvI8LCYwPlCfjmdgojX+L8KgjAiOqlolhI75g
	iz0DGj6GmmzSPbkbn8FhQDGzhBDZDnG9wSKsnqHRw1PV0yrE183Y+EzRTKEg==
X-Received: by 2002:a05:600c:19c6:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-48519887257mr132340595e9.16.1772735527745;
        Thu, 05 Mar 2026 10:32:07 -0800 (PST)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae02a8sm88371115e9.5.2026.03.05.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:32:07 -0800 (PST)
Date: Thu, 5 Mar 2026 18:32:06 +0000
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: dma: idxd: TLB translation fetch operation not supported despite PCI
 ATS enabled
Message-ID: <20260305183206.ch43qpnof6q4lvvd@wrangler>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2B8A0216FC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9284-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmanaouildev@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Hi Vinicius, Dave and others,

I am working on a potential mm feature leveraging the Intel DSA
accelerator. I am trying to get the TLB translation fetch operation
to work (described in section 8.3.11 in the spec [0]). However, I keep
getting error code 0x10 which correponds to "operation not supported",
despite that PCIe ATS is enabled.

I used idxd-config [1] and dsa-perf-micros [2] for testing as well as a
kernel module. This happened both on shared and dedicated queues.

An example with [2] is given below

With [2], Create a shared queue with a single engine

# ./scripts/setup_dsa.sh -d dsa0 -w 1 -m s -e 1

Then run a 4KiB memmove job (opcode 3) with translation fetching (-X).

# dsa_perf_micros -n10 -s4k -i1 -k5 -w1 -o3 -X1
dsa_perf_micros -n10 -s4k -i1 -k5 -w1 -o3 -X1
blen                       4096
bstride                    4096
bstride                    4096
nb_bufs                      10
pg_size                       0
wq_type                       1
batch_sz                      1
iter                          1
nb_cpus                       1
var_mmio                      0
dma                           1
verify                        1
misc_flags                    0
access_op[0]               Write
access_op[1]               Write
place_op[0]              Memory
place_op[1]              Memory
flags_cmask            ffffffff
flags_smask                   0
flags_nth_desc                1
nb_numa_node                  1
cpu_desc_work                 0
Memory affinity
CPUs in node 0:         -1 -1
Buffer Offsets          0 0
dsa_perf_micros: check_comp: desc[0] error
desc addr: 0x7adf31986000
desc[0]: 0x0a00000c00000000
desc[1]: 0x00007adf31987000
desc[2]: 0x0000650dabb381c0
desc[3]: 0x0000000000000000
desc[4]: 0x000000000000a000
desc[5]: 0x0000000000000000
desc[6]: 0x0000000000000000
desc[7]: 0x0000000000000000
dsa_perf_micros: print_status: Comp status 0x10
dsa_perf_micros: main: test run failed

As you can see, it fails with completion status 0x10.

I also tried submitting this directly from the kernel on top of idxd. I
prepared and submitted a dsa_hw_desc as follows (roughly)

struct dsa_hw_desc *hw;

hw->flags = 0;
hw->opcode = DSA_OPCODE_TRANSL_FETCH;
hw->transl_fetch_addr = sg_dma_address(&sg[i]);
hw->region_size = sg_dma_len(&sg[i]);
hw->region_stride = 4096;
hw->priv = 0;

rc = idxd_submit_desc(wq, desc);

and I got the same error code 0x10 in the completion record.

I am on Linux kernel 6.17 on Ubuntu and I tried this on two different
systems

1) Dual socket Intel Sapphire Rapids 4th Gen Xeon(R) Gold 5418N
2) Single socket Intel Emerald Rapids 5th Gen Xeon(R) Gold 5512U

I had the same error on both.

lspci shows that PCI ATS features is enabled for DSA on both. As an
example, on system (2):

# lspci -vvv -s 0000:f2:01.0
        Capabilities: [220 v1] Address Translation Service (ATS)
                ATSCap: Invalidate Queue Depth: 00
                ATSCtl: Enable+, Smallest Translation Unit: 00
        Capabilities: [230 v1] Process Address Space ID (PASID)
                PASIDCap: Exec- Priv+, Max PASID Width: 14
                PASIDCtl: Enable+ Exec- Priv+
        Capabilities: [240 v1] Page Request Interface (PRI)
                PRICtl: Enable+ Reset-
                PRISta: RF- UPRGI- Stopped+
                Page Request Capacity: 00000200, Page Request Allocation: 00000200
        Kernel driver in use: idxd
        Kernel modules: idxd

And this is the output of accel-config list on system (2) for the example above

[
  {
    "dev":"dsa0",
    "read_buffer_limit":0,
    "max_groups":4,
    "max_work_queues":8,
    "max_engines":4,
    "work_queue_size":128,
    "numa_node":0,
    "op_cap":"00000000,00000000,00000000,00000000,00000000,00000000,00000001,003f027d",
    "gen_cap":"0x40915f0107",
    "version":"0x100",
    "state":"enabled",
    "max_read_buffers":96,
    "max_batch_size":1024,
    "configurable":1,
    "pasid_enabled":1,
    "cdev_major":235,
    "clients":0,
    "groups":[
      {
        "dev":"group0.0",
        "read_buffers_reserved":0,
        "use_read_buffer_limit":0,
        "read_buffers_allowed":96,
        "grouped_workqueues":[
          {
            "dev":"wq0.0",
            "mode":"shared",
            "size":128,
            "group_id":0,
            "priority":10,
            "block_on_fault":0,
            "max_batch_size":512,
            "max_transfer_size":2097152,
            "cdev_minor":0,
            "type":"user",
            "name":"app0",
            "driver_name":"user",
            "threshold":128,
            "ats_disable":0,
            "state":"enabled",
            "clients":0
          }
          }
        ],
        "grouped_engines":[
          {
            "dev":"engine0.0",
            "group_id":0
          }
        ]
      },
      {
        "dev":"group0.1",
        "read_buffers_reserved":0,
        "use_read_buffer_limit":0,
        "read_buffers_allowed":96
      },
      {
        "dev":"group0.2",
        "read_buffers_reserved":0,
        "use_read_buffer_limit":0,
        "read_buffers_allowed":96
      },
      {
        "dev":"group0.3",
        "read_buffers_reserved":0,
        "use_read_buffer_limit":0,
        "read_buffers_allowed":96
      }
    ],
    "ungrouped_engines":[
      {
        "dev":"engine0.1"
      },
      {
        "dev":"engine0.2"
      },
      {
        "dev":"engine0.3"
      }
    ]
  }
]

I tried to debug a bit in the kernel, and IOMMU code in the kernel successfully calls
pci_enable_ats() function at initialisation time. So I assume nothing is wrong with
IOMMU, PCI root complex and BIOS options.

Do you have any clue how to get this to work? Or will it ever work in
the first place on these systems? This is not documented anywhere.

Cheers

[0] https://cdrdv2-public.intel.com/857060/341204-006-intel-data-streaming-accelerator-spec.pdf
[1] https://github.com/intel/idxd-config
[2] https://github.com/intel/dsa-perf-micros/tree/main
-- 
~karim


Return-Path: <dmaengine+bounces-9288-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNX3N2rkqWl1HAEAu9opvQ
	(envelope-from <dmaengine+bounces-9288-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 21:15:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92F218115
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 21:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CB6D30502A8
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D53EBF2D;
	Thu,  5 Mar 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANJgrdQL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A692D8376
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740946; cv=none; b=MjXDOXTMMb3btl3KedRmN5DTl14U9E5GjoNiVZz7aBKYnxELznplrHSQbaMQqGGTCWjL0BzyxgwGZb5mglHjHuIg1NBDecNaIDYEsMQVagvlocgwqNUZlj2aai8w2viJwvzxu4yVcGkOnZqeZZYJ7OLPUAvZYeBZkE0+9+6tVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740946; c=relaxed/simple;
	bh=6W4SDADVdclGRhqJXA+waIEDkVSrbUke5nCaxmZqT7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE24efgYN6khWtst1npRSE15152sncn6PR/MwgZNIN8Sk83V8nfWuz2ZudXz5ldEl3Ayi5VVkVFlGnXdxbqDnV2Z2KYefBTA4P3K62EMhZmU6O+2s6t0aF3+ZjnHqU7+wI0FmiyT/yYPtsjMGUXokJlFN97b4TAAScF24nrxX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANJgrdQL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4807068eacbso70998055e9.2
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 12:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772740943; x=1773345743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRf9pqPlxTbJUEsTWhLFNb84aM0ldImFLB7Ieng5mvo=;
        b=ANJgrdQLwt55rdx+o6a5p1NyY4hduhtpKFAWXoTA1LXP324Sbm7oFP6G/glfTe3YYJ
         Gw5RH9z4MjMtHVjbdf8GGmQlfYyZ+JnUnwevO1QfhhtUsZi2EfA7GDigXtFnj2FTKbxA
         w19gckvvyCiikUvxd0nueLB9P/g9H0pmB64VFN0I4vVf3rNxowzP5h4Zms9iOm4jJ+rw
         tNwkfeCO6PWR7m5MAJvmqLKr1mK5zoY+t9mHzBgXAS4VQAe/0g+Vb18z3DrlVenIfkHD
         3AcToXyb088Yh8aZZUyuU50W2PbfHrMs21EdtF5c7SatTQh5MbJlKI64JuPEsEv9ZTho
         M20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740943; x=1773345743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRf9pqPlxTbJUEsTWhLFNb84aM0ldImFLB7Ieng5mvo=;
        b=LuJDn3r1bM9tiEE7TvBFn1+zERhMTRe/b8kMxW7r54X+v0rOoo4ytAICWL7bVkrU7Q
         pMGZjzdf7F20anb7mVd/i+qP7LmLfTAZA5v5eGO+UdBHnvsJ+ikYzeu8H+TSSdfXWxQi
         yRD6EHi/uRcCNzaNg8ng66O1bxHxh3VAk32fWsEvmSbTijKjfxefF+dKrnJQtWMdLMH5
         gLWum5qNvw7pF16iMEH2vo473pHBIp1SLOWKV2mypVslqWKs6Ki6YkLiIFJIO8S4Zaah
         B+GkyTwmXCe0F5F57ZNy+kBOZXZvVPJ/AsNjdTkGUMTa8TwsgrtkBLG10DDmOkIiJtKh
         8iHA==
X-Forwarded-Encrypted: i=1; AJvYcCVTmEuGxSTJBcHNxyxAKyGlf1IjA+aMcy/FOLL4j3hlK8x3ZfLzZd0N5KTNZVKC/fqVN+6Cq4EwoaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPZ0vYH6Bvs9OntOi3Vi9negj+uqLW6tlOubzEILTTSB8f4ux
	rKcCdL07w/BMhCOLXsdZg92j4aM970qpSNDdTlEuwkyuMecC9xRAkwAI
X-Gm-Gg: ATEYQzz+bKlxA48O0UF+M2KuvcxcaE2IShrnBHfm+GmEaFHqIUGKidOvTWTNWoZBl51
	wyOLxqkY3rVWLQJK/58DjGL+XSL2LxFJi9kVwkoZLqrZCfjp9dvbUxfejBz/FlM7tXyPk0DbRes
	6siKCEmSjv7f91jZaieiyOvwYZAysI3Ym/3YVuibdtru4WiLGlX/fyeE90n+rnq5c/DEh/JgwxJ
	ZuXE8GpezIhXHASh3W5/Rj0++ppIBG4AWPGz0OTF+kV8mr3i8xmyo9fUTRakdewAO51cVFvkyTp
	WcnTFetOvC/pnoQn4UOpfkXhcDGJ23JfNRMoKuqsOMs+k9YcOt2uig7/uxvu0svyjeY/Jojq9FY
	+yPGQK2hcauWc0adeXaTVZrjEeVDRm5MQAgr5t9RngSZt+omiN+pvHxDJ/94AgsUgcAhYc285si
	5Fkycfs5DhQKQGb+Hl2UteMK9RG9FToXcIFKvK3fkKYpwEfAqyXraG2XjHRA==
X-Received: by 2002:a05:600c:1550:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-485235fb068mr11436795e9.29.1772740942942;
        Thu, 05 Mar 2026 12:02:22 -0800 (PST)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fa87e56sm61369055e9.0.2026.03.05.12.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:02:22 -0800 (PST)
Date: Thu, 5 Mar 2026 20:02:21 +0000
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dma: idxd: TLB translation fetch operation not supported despite
 PCI ATS enabled
Message-ID: <20260305200221.kp3hcwdakk5yegoe@wrangler>
References: <20260305183206.ch43qpnof6q4lvvd@wrangler>
 <8aac54f1-fc2f-4686-878e-456cdefccac4@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aac54f1-fc2f-4686-878e-456cdefccac4@intel.com>
X-Rspamd-Queue-Id: DF92F218115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9288-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmanaouildev@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:url]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:51:19AM -0700, Dave Jiang wrote:
> 
> 
> On 3/5/26 11:32 AM, Karim Manaouil wrote:
> > Hi Vinicius, Dave and others,
> > 
> > I am working on a potential mm feature leveraging the Intel DSA
> > accelerator. I am trying to get the TLB translation fetch operation
> > to work (described in section 8.3.11 in the spec [0]). However, I keep
> > getting error code 0x10 which correponds to "operation not supported",
> > despite that PCIe ATS is enabled.
> 
> Have you checked the op_cap sysfs attribute (OPCAP register) and see if the platform you are using supports the opcode? From the error code you are reporting, it appears the CPU you are using does not support that op. You may need a Granite Rapids (or equivalent gen) platform for that to be available. I don't recall that OP for DSA v1.0 which is on your SPR and EMR platforms.
>

You're right. I just checked the op_cap. It's not supported on SPR and EMR. Thank you.

> DJ
> 
> > 
> > I used idxd-config [1] and dsa-perf-micros [2] for testing as well as a
> > kernel module. This happened both on shared and dedicated queues.
> > 
> > An example with [2] is given below
> > 
> > With [2], Create a shared queue with a single engine
> > 
> > # ./scripts/setup_dsa.sh -d dsa0 -w 1 -m s -e 1
> > 
> > Then run a 4KiB memmove job (opcode 3) with translation fetching (-X).
> > 
> > # dsa_perf_micros -n10 -s4k -i1 -k5 -w1 -o3 -X1
> > dsa_perf_micros -n10 -s4k -i1 -k5 -w1 -o3 -X1
> > blen                       4096
> > bstride                    4096
> > bstride                    4096
> > nb_bufs                      10
> > pg_size                       0
> > wq_type                       1
> > batch_sz                      1
> > iter                          1
> > nb_cpus                       1
> > var_mmio                      0
> > dma                           1
> > verify                        1
> > misc_flags                    0
> > access_op[0]               Write
> > access_op[1]               Write
> > place_op[0]              Memory
> > place_op[1]              Memory
> > flags_cmask            ffffffff
> > flags_smask                   0
> > flags_nth_desc                1
> > nb_numa_node                  1
> > cpu_desc_work                 0
> > Memory affinity
> > CPUs in node 0:         -1 -1
> > Buffer Offsets          0 0
> > dsa_perf_micros: check_comp: desc[0] error
> > desc addr: 0x7adf31986000
> > desc[0]: 0x0a00000c00000000
> > desc[1]: 0x00007adf31987000
> > desc[2]: 0x0000650dabb381c0
> > desc[3]: 0x0000000000000000
> > desc[4]: 0x000000000000a000
> > desc[5]: 0x0000000000000000
> > desc[6]: 0x0000000000000000
> > desc[7]: 0x0000000000000000
> > dsa_perf_micros: print_status: Comp status 0x10
> > dsa_perf_micros: main: test run failed
> > 
> > As you can see, it fails with completion status 0x10.
> > 
> > I also tried submitting this directly from the kernel on top of idxd. I
> > prepared and submitted a dsa_hw_desc as follows (roughly)
> > 
> > struct dsa_hw_desc *hw;
> > 
> > hw->flags = 0;
> > hw->opcode = DSA_OPCODE_TRANSL_FETCH;
> > hw->transl_fetch_addr = sg_dma_address(&sg[i]);
> > hw->region_size = sg_dma_len(&sg[i]);
> > hw->region_stride = 4096;
> > hw->priv = 0;
> > 
> > rc = idxd_submit_desc(wq, desc);
> > 
> > and I got the same error code 0x10 in the completion record.
> > 
> > I am on Linux kernel 6.17 on Ubuntu and I tried this on two different
> > systems
> > 
> > 1) Dual socket Intel Sapphire Rapids 4th Gen Xeon(R) Gold 5418N
> > 2) Single socket Intel Emerald Rapids 5th Gen Xeon(R) Gold 5512U
> > 
> > I had the same error on both.
> > 
> > lspci shows that PCI ATS features is enabled for DSA on both. As an
> > example, on system (2):
> > 
> > # lspci -vvv -s 0000:f2:01.0
> >         Capabilities: [220 v1] Address Translation Service (ATS)
> >                 ATSCap: Invalidate Queue Depth: 00
> >                 ATSCtl: Enable+, Smallest Translation Unit: 00
> >         Capabilities: [230 v1] Process Address Space ID (PASID)
> >                 PASIDCap: Exec- Priv+, Max PASID Width: 14
> >                 PASIDCtl: Enable+ Exec- Priv+
> >         Capabilities: [240 v1] Page Request Interface (PRI)
> >                 PRICtl: Enable+ Reset-
> >                 PRISta: RF- UPRGI- Stopped+
> >                 Page Request Capacity: 00000200, Page Request Allocation: 00000200
> >         Kernel driver in use: idxd
> >         Kernel modules: idxd
> > 
> > And this is the output of accel-config list on system (2) for the example above
> > 
> > [
> >   {
> >     "dev":"dsa0",
> >     "read_buffer_limit":0,
> >     "max_groups":4,
> >     "max_work_queues":8,
> >     "max_engines":4,
> >     "work_queue_size":128,
> >     "numa_node":0,
> >     "op_cap":"00000000,00000000,00000000,00000000,00000000,00000000,00000001,003f027d",
> >     "gen_cap":"0x40915f0107",
> >     "version":"0x100",
> >     "state":"enabled",
> >     "max_read_buffers":96,
> >     "max_batch_size":1024,
> >     "configurable":1,
> >     "pasid_enabled":1,
> >     "cdev_major":235,
> >     "clients":0,
> >     "groups":[
> >       {
> >         "dev":"group0.0",
> >         "read_buffers_reserved":0,
> >         "use_read_buffer_limit":0,
> >         "read_buffers_allowed":96,
> >         "grouped_workqueues":[
> >           {
> >             "dev":"wq0.0",
> >             "mode":"shared",
> >             "size":128,
> >             "group_id":0,
> >             "priority":10,
> >             "block_on_fault":0,
> >             "max_batch_size":512,
> >             "max_transfer_size":2097152,
> >             "cdev_minor":0,
> >             "type":"user",
> >             "name":"app0",
> >             "driver_name":"user",
> >             "threshold":128,
> >             "ats_disable":0,
> >             "state":"enabled",
> >             "clients":0
> >           }
> >           }
> >         ],
> >         "grouped_engines":[
> >           {
> >             "dev":"engine0.0",
> >             "group_id":0
> >           }
> >         ]
> >       },
> >       {
> >         "dev":"group0.1",
> >         "read_buffers_reserved":0,
> >         "use_read_buffer_limit":0,
> >         "read_buffers_allowed":96
> >       },
> >       {
> >         "dev":"group0.2",
> >         "read_buffers_reserved":0,
> >         "use_read_buffer_limit":0,
> >         "read_buffers_allowed":96
> >       },
> >       {
> >         "dev":"group0.3",
> >         "read_buffers_reserved":0,
> >         "use_read_buffer_limit":0,
> >         "read_buffers_allowed":96
> >       }
> >     ],
> >     "ungrouped_engines":[
> >       {
> >         "dev":"engine0.1"
> >       },
> >       {
> >         "dev":"engine0.2"
> >       },
> >       {
> >         "dev":"engine0.3"
> >       }
> >     ]
> >   }
> > ]
> > 
> > I tried to debug a bit in the kernel, and IOMMU code in the kernel successfully calls
> > pci_enable_ats() function at initialisation time. So I assume nothing is wrong with
> > IOMMU, PCI root complex and BIOS options.
> > 
> > Do you have any clue how to get this to work? Or will it ever work in
> > the first place on these systems? This is not documented anywhere.
> > 
> > Cheers
> > 
> > [0] https://cdrdv2-public.intel.com/857060/341204-006-intel-data-streaming-accelerator-spec.pdf
> > [1] https://github.com/intel/idxd-config
> > [2] https://github.com/intel/dsa-perf-micros/tree/main
> 

-- 
~karim


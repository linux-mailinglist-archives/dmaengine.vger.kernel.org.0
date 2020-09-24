Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38889277394
	for <lists+dmaengine@lfdr.de>; Thu, 24 Sep 2020 16:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgIXOHg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Sep 2020 10:07:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:51304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgIXOH1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Sep 2020 10:07:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DD09AB0E;
        Thu, 24 Sep 2020 14:07:25 +0000 (UTC)
Date:   Thu, 24 Sep 2020 14:07:25 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     David Laight <David.Laight@ACULAB.COM>,
        'Dave Jiang' <dave.jiang@intel.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "jing.lin@intel.com" <jing.lin@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] x86/asm: Carve out a generic movdir64b() helper
 for general usage
In-Reply-To: <20200924101506.GD5030@zn.tnic>
Message-ID: <alpine.LSU.2.20.2009241356020.20802@wotan.suse.de>
References: <160090233730.44288.4446779116422752486.stgit@djiang5-desk3.ch.intel.com> <160090264332.44288.7575027054245105525.stgit@djiang5-desk3.ch.intel.com> <a8c81da06df2471296b663d40b186c92@AcuMS.aculab.com> <20200924101506.GD5030@zn.tnic>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

even though we hashed it out downthread, let me make some additional 
remarks:

On Thu, 24 Sep 2020, Borislav Petkov wrote:

> > 	/* MOVDIR64B [rdx], rax */

This comment is confusing as it uses Intel syntax for the operand forms, 
but AT&T order (dest last).

> 	volatile struct { char _[64]; } *__dst = dst;
> 
> 	...
> 
> 	: "=m" (__dst)

This and the other occurences in this thread up to now always miss that 
the 'm' constraints want the object itself, not the address of the object.  
So you want '"m" (*__src)', same for dst, and so on.

> Micha, the instruction is:
> 
> MOVDIR64B %(rdx), rax
> 
> "Move 64-bytes as direct-store with guaranteed 64-byte write atomicity
> from the source memory operand address to destination memory address
> specified as offset to ES segment in the register operand."

It's unfortunate that the introduction of this mnemonic into binutils 
did it wrong already, but what the instruction should really read like in 
AT&T mode is:

  movdir64b (%rdx), (%rax)
or even
  movdir64b (%rdx), es:(%rax)

because both are memory operands really (even though the destination can 
only be encoded with a direct register, as these are the constraints of 
x86 insn encodings).  It's comparable to movs, which, also having two 
memory operands is written:

  movsb  %ds:(%rsi),%es:(%rdi)


Ciao,
Michael.

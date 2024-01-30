Return-Path: <dmaengine+bounces-910-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FE4842D5A
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 20:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E66D1C2210E
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jan 2024 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C671B32;
	Tue, 30 Jan 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5RzVUB7"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8769DFC;
	Tue, 30 Jan 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644490; cv=none; b=sCEhltkd27C6mtDeRg5FhM57TR2AoS49h5IpWpIFG6bPIjhjySEzi19UKXrXM/xhQ1H3tMdPt0ABVz2E3whngja2MAQ+rH+/TCDjkHfGT9NJxT7mXTnUzPAMGiNCGdcaCnF/+dpoFZnUXIlh7Qe8hn8H2sGVVfzE2nUtuMUd0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644490; c=relaxed/simple;
	bh=gPwbbno0aGugg781DXMwRoNug/UCpH5hFB/aMixfvwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRtY+b3dRBvHJ/JhshFYaKy5L1dU+20xt9BadqZB08eUnCiHrG4Z0Ay9b5XO6IYC08AJ6g7Xnqy3zEr77B0FkPqD+6+khO12Co2YwEHJLSXc3ql6Il11yY1g+NNTMwIw0N82pyq5ojEZT0i7xoRLOf4DbRBIMX0Qly6egEvwlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5RzVUB7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68c420bf6f1so1325456d6.1;
        Tue, 30 Jan 2024 11:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706644488; x=1707249288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQJp9jA6d6XZuU5QdlSPAbpEyuca5EDh5G5T6f/NIxE=;
        b=A5RzVUB7l+6tjVIhR3dbs1k7WJxI2j8IkXK05deBRXcVrR7DVM5l0LAxd+fmfmB68N
         NSnVtvkfbQamx4PNOx5vd60MkN2gEE9Etmzvnm9BEORwPzudT2ssa1xPHHIkbdNKIprt
         8j+ZoIYJrgLPWHW00DKhOrbWBPDEJNaLBGH2h5sBJC/9n1A9gBztCP/BDHM2mgyFWjxq
         2NJFMahVjboOatUpis9XxPLS7oo1s0oe6L/LQpLgVvodZ1tIwPfDvQh9PtYkRHSBvgPl
         mibmxXqeidfYpjd6HKfGqUyS1Tmf6sxznfsssiT/MdF9I2ECwj/Y9k8U3ZpmjIScThlL
         z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644488; x=1707249288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQJp9jA6d6XZuU5QdlSPAbpEyuca5EDh5G5T6f/NIxE=;
        b=MdgLDtLnI1wY+r0yToZd/DgtxolpAfkvyLVI7BHE5nEJqywb1fuQAz+pVY8vgdMGxq
         b7dXkQ757MVavTgqbbwZOoI5p/Yeq6qvenqA2WLOrdGeVtKyYru8DZqBIAZmm9aZ2Wy2
         cNU3W6XL2Nn3B77eewkUv02Qylj7cyKuAbXVBZvvZmP4krDuG/jGqaXr/Ukj2ZJkjIs2
         8/xJo5lEpoTcMiY/MxnQ9oDz6/hZBIUl31zZ7+v3Sd/+hZ+RqnX/3eh8iAuFJmZ6TzTQ
         KPAFnLRubYv6AkMvIf6A0JvwpHnZbx4DAgZxupjkcjYNb612kPvOCJ5aMralCXeq868n
         OH8g==
X-Gm-Message-State: AOJu0YwESXhp/GXhh9cOjKqPcAHdFRawzIyCdAg0xnuBlb9ofdA6eQdw
	MdKJk5CiWj2d+TauVefDVmQbe5GmNa7VNps2h0dFQZwx26grWndd
X-Google-Smtp-Source: AGHT+IEYpRvCcOvTByPEbJxBYIEAA7nFLJ0D6RhnyNwbg/qeiqFvNHRR58UTfQQx7B1gLl7ssYxp7A==
X-Received: by 2002:a05:6214:29ce:b0:681:7231:de7d with SMTP id gh14-20020a05621429ce00b006817231de7dmr2465910qvb.42.1706644488140;
        Tue, 30 Jan 2024 11:54:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUUo9FEqdjEVzcXpX6Yk8Y2+ntQ7fJzvcC4CNNAUZ3/5ZljTHaby7QlbcBGP9/rGBLHt6iwkmPra8M9eShMflAujDVuzllXbi1B7P5KmPpbzcCyFJ+1xmQlAhQgpCzSo6Lx1aZV5M2clVBGUIL3P5jAxr9bXVood44kdqAGiQxjeNYao4wxK2nyIlJpW8s67SS4MBP8hPMcTeiQ+4nXgHrWFBFzCE7vy/q9bOefmDMD5e0UuDs17mF7IDKo3Gu5lRCKux922tvyq6ryRwQNIEEhTbj0DDILXGXitJgffGOTdrP5wEANSq+Wkf2FlxZozwDwAdzANeSLUun5Sy9jmibzU7XGJpIVb7KOcApMiJOItkhGgzWGJWJXeuEpicMFbmf8ml2dAJ8yEzX2GWlMwxm6/E8g8tnS7z5jJMYJpo75Qo2pmNJbXwqQBFYIvQ==
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id mc8-20020a056214554800b006819636ba87sm4716749qvb.7.2024.01.30.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:54:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F33501200043;
	Tue, 30 Jan 2024 14:54:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 30 Jan 2024 14:54:47 -0500
X-ME-Sender: <xms:BlS5ZcnGCJI3T4OM8KlSdsaLdPmczQy2e9MiMWoIbW8tbC07wVwhuQ>
    <xme:BlS5Zb1Vl-cUpCfEIkUwGtSRn_n7nzlnaLUpTo_W80oQEXDZwZXrCPtrxaDVayBv2
    ORghb4rQXyZgVQ3Sw>
X-ME-Received: <xmr:BlS5ZaqnE3qisdeyqU8bclsoqvUVoB7nYKakaz3J1xF1RBxyE4nuaOQwIEEkWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtjedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdevhfehueektdevhfettddv
    teevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BlS5ZYmLnOSye25CNTWbyhp5qppfvfZmR8zW6UmAZOri3_ZZkwce2A>
    <xmx:BlS5Za1DlKhXI7lla6uFdN3w3L7bliYKNaQ5nvgKv6d0BFkxAkdVhw>
    <xmx:BlS5ZfvaUOaKCCbCOWtxCpg46djAQYqW2nSCltRVOKyzyp01EVrE0w>
    <xmx:BlS5ZUNX2shbwDSW9NRQenq3gC283Cp9Sp8hwtuDC2NnKwzsdLHCB1DL7eo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jan 2024 14:54:46 -0500 (EST)
Date: Tue, 30 Jan 2024 11:53:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Nikhil Rao <nikhil.rao@intel.com>, Tony Zhu <tony.zhu@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Change wmb() to smp_wmb() when copying
 completion record to user space
Message-ID: <ZblTystHpVkvjbkv@boqun-archlinux>
References: <20240130025806.2027284-1-fenghua.yu@intel.com>
 <Zbk4wGNcB-g91Vr0@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbk4wGNcB-g91Vr0@FVFF77S0Q05N>

On Tue, Jan 30, 2024 at 05:58:24PM +0000, Mark Rutland wrote:
> This patch might be ok (it looks reasonable as an optimization), but I think
> the description of wmb() and smp_wmb() is incorrect. I also think that you're

Agreed. A wmb() -> smp_wmb() change can only be an optimization rather
than a fix.

> missing an rmb()/smp_rmb()eor equivalent on the reader side.
> 
> On Mon, Jan 29, 2024 at 06:58:06PM -0800, Fenghua Yu wrote:
> > wmb() is used to ensure status in the completion record is written
> > after the rest of the completion record, making it visible to the user.
> > However, on SMP systems, this may not guarantee visibility across
> > different CPUs.
> > 
> > Considering this scenario that event log handler is running on CPU1 while
> > user app is polling completion record (cr) status on CPU2:
> > 
> > 	CPU1				CPU2
> > event log handler			user app
> > 
> > 					1. cr = 0 (status = 0)
> > 2. copy X to user cr except "status"
> > 3. wmb()
> > 4. copy Y to user cr "status"
> > 					5. poll status value Y
> > 				 	6. read rest cr which is still 0.
> > 					   cr handling fails
> > 					7. cr value X visible now
> > 
> > Although wmb() ensure value Y is written and visible after X is written
> > on CPU1, the order is not guaranteed on CPU2. So user app may see status
> > value Y while cr value X is still not visible yet on CPU2. This will
> > cause reading 0 from the rest of cr and cr handling fails.
> 
> The wmb() on CPU1 ensures the order of the reads, but you need an rmb() on CPU2
> between reading the 'status' and 'rest' parts; otherwise CPU2 (or the
> compiler!) is permitted to hoist the read of 'rest' early, before reading from
> 'status', and hence you can end up with a sequence that is effectively:
> 
> 	CPU1				CPU2
>   event log handler			user app
> 					
>   					1. cr = 0 (status = 0)
>   				 	6a. read rest cr which is still 0.
>   2. copy X to user cr except "status"
>   3. wmb()
>   4. copy Y to user cr "status"
>   					5. poll status value Y
>   					6b. cr handling fails
>   					7. cr value X visible now
> 
> Since this is all to regular cacheable memory, it's *sufficient* to use
> smp_wmb() and smp_rmb(), but that's an optimization rather than an ordering
> fix.
> 
> Note that on x86_64, TSO means that the stores are in-order (and so smp_wmb()
> is just a compiler barrier), and IIUC loads are not reordered w.r.t. other
> loads (and so smp_rmb() is also just a compiler barrier).
> 
> > Changing wmb() to smp_wmb() ensures Y is written after X on both CPU1
> > and CPU2. This guarantees that user app can consume cr in right order.

A barrier can only provide ordering for memory accesses on the same CPU,
so this doesn't make any sense.

> 
> This implies that smp_wmb() is *stronger* than wmb(), whereas smp_wmb() is
> actually *weaker* (e.g. on x86_64 wmb() is an sfence, whereas smp_wmb() is a
> barrier()).
> 
> Thanks,
> Mark.
> 
> > 
> > Fixes: b022f59725f0 ("dmaengine: idxd: add idxd_copy_cr() to copy user completion record during page fault handling")
> > Suggested-by: Nikhil Rao <nikhil.rao@intel.com>
> > Tested-by: Tony Zhu <tony.zhu@intel.com>

Since it has a "Fixes" tag and a "Tested-by" tag, I'd assume there has
been a test w/ and w/o this patch showing it can resolve a real issue
*constantly*? If so, I think x86 might be broken somewhere.

[Cc x86 maintainers]

Regards,
Boqun

> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > ---
> >  drivers/dma/idxd/cdev.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> > index 77f8885cf407..9b7388a23cbe 100644
> > --- a/drivers/dma/idxd/cdev.c
> > +++ b/drivers/dma/idxd/cdev.c
> > @@ -681,9 +681,10 @@ int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
> >  		 * Ensure that the completion record's status field is written
> >  		 * after the rest of the completion record has been written.
> >  		 * This ensures that the user receives the correct completion
> > -		 * record information once polling for a non-zero status.
> > +		 * record information on any CPU once polling for a non-zero
> > +		 * status.
> >  		 */
> > -		wmb();
> > +		smp_wmb();
> >  		status = *(u8 *)cr;
> >  		if (put_user(status, (u8 __user *)addr))
> >  			left += status_size;
> > -- 
> > 2.37.1
> > 
> > 


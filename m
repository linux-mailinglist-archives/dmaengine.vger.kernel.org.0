Return-Path: <dmaengine+bounces-10150-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DhrKr2p72kCDwEAu9opvQ
	(envelope-from <dmaengine+bounces-10150-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:23:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED0478803
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C95F3038C7F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4A63E63A3;
	Mon, 27 Apr 2026 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2scZpbK"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD83E274D;
	Mon, 27 Apr 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314054; cv=none; b=u1/Ds/LwShlIadKzXh+lhNI4gPsN9exef3ie1BjXf1WAoD2miBL1hJLkSmjiQgFnkwueiKw1ZE39Eh5sZqwKyghwgVBf9T+vWcRQ/13dBpNuCMgX9ogM/K0pcG8KWxEesYHqnIe5mg2OvSvN6I6WvoH2aQOhDsmlwbKWSrX6Jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314054; c=relaxed/simple;
	bh=fSfdZ5/fBIJBn92+lTQ8RknrFiSruKk4Zm5FPbyuhQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZjCzRBOdWpzK3uvkI8gRjnAcZaKmKArWlmpDhiw0GgVB4zsMAYIXjZcAWTXdrpnG0sJUq1ajJCjvn36+YUmAjH6Vph2VJw/sM7s7qVdAR8PkRST9bRCOJncBwN1OtrW0UMhsYc5r6fSftL5OFZBrBgih5DvSnSbgr9V0twHDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2scZpbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCCFC2BCB5;
	Mon, 27 Apr 2026 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777314053;
	bh=fSfdZ5/fBIJBn92+lTQ8RknrFiSruKk4Zm5FPbyuhQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2scZpbKenpOejPaCkxdr8Fr6c4RornKyxLjF0dKFYhSlw+matCdj3SDWlLeqEo9E
	 a373XI9Iold2YwxLkAFI1OVkbxbR9JLgxu/comiCZJeBJjQK8IiPFbF3a0OQIu5zFJ
	 z32D8XDVz5Fo00XfpR09lc3WO+fPx7ont3FOA+TL4jxGM7w1J5Z2cHWcv2Vi05coRU
	 6lIPjD/Eh4XtMiOh4PUlJfQ+hbcnF50oIaF0Y5is14Jb9Uy7pNbq6e4WVWxwPn3QZF
	 F5175xYuXBtUSK+HvgeuPZTDTXog5e6524IUP62vgqpWl/U/vR5Pqvo+DbOYeGkne+
	 cSOzK+yVIhXWw==
Message-ID: <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
Date: Mon, 27 Apr 2026 20:20:38 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-x25@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-sound@vger.kernel.org,
 sound-open-firmware@alsa-project.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ae-j2_QirCySZD02@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 51ED0478803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10150-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



Le 27/04/2026 à 19:58, Yury Norov a écrit :
> On Mon, Apr 27, 2026 at 07:13:48PM +0200, Christophe Leroy (CS GROUP) wrote:
>> At the time being, x86 and arm64 are missing unsafe_copy_from_user().
> 
> No, they don't. They (should) rely on a generic implementation from
> linux/uaccess.h, like every other arch, except for  PPC and RISCV.
> 
> But they #define arch_unsafe_get_user, and the unsafe_copy_from_user()
> becomes undefined conditionally on that.
> 
> So please, fix that bug instead of introducing another arch flavor.
> We'd always choose generic version, unless there's strong evidence
> that arch one is better.

But they both implement the exact same unsafe_copy_to_user(). What is 
the difference here ?

Should that function become generic too ?

Christophe

> 
> 
> Thanks,
> Yury
>   
>> Add it.
>>
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> ---
>>   arch/x86/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
>>   1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
>> index 3a0dd3c2b233..10c458ffa399 100644
>> --- a/arch/x86/include/asm/uaccess.h
>> +++ b/arch/x86/include/asm/uaccess.h
>> @@ -598,7 +598,7 @@ _label:									\
>>    * We want the unsafe accessors to always be inlined and use
>>    * the error labels - thus the macro games.
>>    */
>> -#define unsafe_copy_loop(dst, src, len, type, label)				\
>> +#define unsafe_put_loop(dst, src, len, type, label)				\
>>   	while (len >= sizeof(type)) {						\
>>   		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
>>   		dst += sizeof(type);						\
>> @@ -611,10 +611,29 @@ do {									\
>>   	char __user *__ucu_dst = (_dst);				\
>>   	const char *__ucu_src = (_src);					\
>>   	size_t __ucu_len = (_len);					\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>> +} while (0)
>> +
>> +#define unsafe_get_loop(dst, src, len, type, label)				\
>> +	while (len >= sizeof(type)) {						\
>> +		unsafe_get_user(*(type __user *)(src),(type *)(dst),label);	\
>> +		dst += sizeof(type);						\
>> +		src += sizeof(type);						\
>> +		len -= sizeof(type);						\
>> +	}
>> +
>> +#define unsafe_copy_from_user(_dst,_src,_len,label)			\
>> +do {									\
>> +	char *__ucu_dst = (_dst);					\
>> +	const char __user *__ucu_src = (_src);				\
>> +	size_t __ucu_len = (_len);					\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>>   } while (0)
>>   
>>   #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>> -- 
>> 2.49.0
>>



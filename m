Return-Path: <dmaengine+bounces-9702-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HocB5ujx2k6aAUAu9opvQ
	(envelope-from <dmaengine+bounces-9702-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 10:47:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0E34DF45
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 10:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B32E9301CEE5
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414737475C;
	Sat, 28 Mar 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbCCUYnd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549FA378D68
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774691221; cv=none; b=IYl3FVzdzrAPVABeBFv9pCyDmT9+cgT3K/DIpSKvSNATDIQ8m42YG6SVStX7gg5ThOdMd5CVbg7ktzORyzX6PijCUJNins/D6MD1nxVb+nf8rrcSJdIjHPSyquDlIR1g7q9DN99WYTRStVL2ZeRRHQdFSUqSxY0bBvmBqN3ixbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774691221; c=relaxed/simple;
	bh=Mug/7k7yiQUruxGBnY8AYdjOaizJTDak/1tlC45nw+M=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=OiiCU7h0dM6QQxdnxhOy/6hKYFRtyrdvbKeAthsoZXS/v5e0yLvYYqypEuUUYRH4ePR7k+4FrSyl9zhGZjbqakSqhXvkum4+8mdP4mE7vhsJdAe89Ge3YJsXvAzqkzgFK3iggMkrktux+ORmIdTCIditGau2ZhMXnEdIK3VIFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbCCUYnd; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-128e4d0cc48so3592595c88.1
        for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774691218; x=1775296018; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm84PKI95ws94X4le7u52sogEFGb/3XJpC4WJ7nzO9w=;
        b=hbCCUYnd03IEV2qXqs7pGx5GJHzmQjAmJFHIUJUSoeupOjNiBiTJOvhK5n91Yr42VX
         TkLuYzQAwKv5mVjMawF6lGGn0EMRt5TrJzDiI9cCuM4HUUVpdSY9b8JnVzkmu9H5Vjo5
         /4KKlvt+wKCRm/5J+jepihAftOgGExBt4RYGlgXyhLEE9NCjfC0+/siGMIi8QyEp1yt4
         bGaIfM0FzWUshpMunFz2C1xuK1oD0etOWt+GLT9hylxnuLU01HoYhxCOKMt1pIrvGvjH
         ic4YCCEUSsZ+p4yyoE4JjrvfZTrNUjSWeZYnvul58kYyRDYnZF7fztmREO2mv1iKJ1Ed
         M7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774691218; x=1775296018;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm84PKI95ws94X4le7u52sogEFGb/3XJpC4WJ7nzO9w=;
        b=Pe2QBVQmgOAvpYARJTA/KDPCfmAxCLUmMYiNh7mm7znjYj0GuNbpr44SJYqdR+aX9Y
         +QQ8lUcVc6LNWot0NN2ZbjicnbAKYkVqkNf13+PVNRQDXjJjSuKypSs8jOt17Jux0H0X
         5eFlV1nkfJOdSZkxU+/IgLcmds77Gkrj+nUiQCxDd8zjR0lqFR3L05mPu9z6kOLc8A7+
         p4TAglPA/nUayUIPDgKI+CZ/8NF+8PiERXbIoQurr/fi1EudgMSOqLrF6Sc9Ld0+FlVF
         HEuhYHhsOO3SzIo31AUjegyHknua3pLeBSlz3lHzuNIyZNGDy+bgSouTO5yepYM619+l
         cMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKYH36JVlq33SfDKwNppfek8zH+o/1Q2B0wC9kHtr7OIpFuxXoDaLaCZuFYpYeN99Jx5dJ5m887n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdQAAmV0fIuylnHViqJ/dKs7tzacWpRcJbe1tqjRl09ZHDnn2
	2Vqy3ryL6KEqJAtAF3sNS98UvRoxYPlU0yik6VvQXYCynzY1vvt7GCud
X-Gm-Gg: ATEYQzzsSfNzvXlDqGHdRjD6Tgl09w8zoJlGu3vUKoIv1AtWrQQtj8T8WWIEEkVb8Fz
	BBy0RseKgzi9PFWfIaTafg7E8FyGzl2V8xPTR1MxLpyT0hSsAkJwelqcFnKvBZhlV1aMhYJMPyL
	W3TW8SX88u8Hy4oHPa0QEkIkMnp+BYJYGXMHE5mKNE+0nq5iPHCIKCcAnHDsoWnslVSiHnAC64d
	75SyEyMYuSeKUivgsLMB2QFW6yMVSLrlfqT7MHlN+pIk9Czrw75NWMyrw5Pi8hxXOlSgwkwXC+1
	1WoTDI6t2YSCuoF8heeavaTjigo3a3FmtEaKWG34gL09T0gUQemw/NXWy797S1LnI4hPwnJe6K4
	t1FDg2mKrfiTEUMCp0kIQYvmso+U8XjswTPOb0gVMhqt20bbTdj4JPlkOYeB4wX6NPSgf9yMx9N
	dO7CXDrAyqJoP+ZewT0Kc69sfKnkhrIJfQa5O7NA==
X-Received: by 2002:a05:7022:6085:b0:123:345b:ba05 with SMTP id a92af1059eb24-12ab28cb38cmr3135449c88.22.1774691218233;
        Sat, 28 Mar 2026 02:46:58 -0700 (PDT)
Received: from localhost ([104.28.227.186])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm1773856c88.4.2026.03.28.02.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:46:57 -0700 (PDT)
From: Troy Mitchell <troymitchell988@gmail.com>
X-Google-Original-From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Mar 2026 17:46:54 +0800
Message-Id: <DHEBJ4VVDDY2.2KRIW6EP7EXOL@linux.spacemit.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan"
 <dlan@kernel.org>, "Vinod Koul" <vkoul@kernel.org>, "Frank Li"
 <Frank.Li@kernel.org>, "Guodong Xu" <guodong@riscstar.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <dmaengine@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] dt-bindings: dmaengine: Add SpacemiT K1 DMA
 request definitions
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
 <20260326-k3-pdma-v2-1-ca94ca7bb595@linux.spacemit.com>
 <20260327-fancy-nondescript-mouse-cfd6f3@quoll>
In-Reply-To: <20260327-fancy-nondescript-mouse-cfd6f3@quoll>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9702-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[troymitchell988@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1BA0E34DF45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Mar 27, 2026 at 3:27 PM CST, Krzysztof Kozlowski wrote:
> On Thu, Mar 26, 2026 at 04:17:16PM +0800, Troy Mitchell wrote:
>> From: Guodong Xu <guodong@riscstar.com>
>>=20
>> Add the DMA request numbers for non-secure peripherals of the K1 SoC
>> from SpacemiT.
>>=20
>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> ---
>
> No changelog - neither here, nor in commit msg.
My apologies, patches 1-6 were added in v2.
I missed including this in the version history..

>
>>  include/dt-bindings/dma/k1-pdma.h | 56 ++++++++++++++++++++++++++++++++=
+++++++
>
> So previous review applies, no? Was there such?
No, since it's a new addition, there are naturally no previous reviews.

                            - Troy


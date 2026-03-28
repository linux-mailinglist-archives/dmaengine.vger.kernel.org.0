Return-Path: <dmaengine+bounces-9703-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJNICFekx2k6aAUAu9opvQ
	(envelope-from <dmaengine+bounces-9703-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 10:50:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8409334DF7F
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 549ED3019056
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160193783BE;
	Sat, 28 Mar 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXMZ+ZMl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C912EB860
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774691311; cv=none; b=MiDWJUWpdjmy2HAXjPEUOInpaCu61nUgyWrhxBZ6VgWmWDNQFjm02mX4+y84dfklqWvO05A08slNJ5N3d3If19RvcH9kgw7/jD9UWP7Gn70Z0zTwSw5arxxzAfAbhMVqPW6PF+Vdf2us/H+g6UFR/Ip3osK02/4dX8isl6Tx38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774691311; c=relaxed/simple;
	bh=H0NsGRh1ZLqqimD4Zi9vPUYMg9ZH77e8pUdX2q1gGgY=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=pOGVy23RY0REe7+5GNY45SZyImLEAXfZgNojk8KCtiCQlsu9CWcSSG2v/RCOd1kqepYQGpsx+2bWtMOZSdTtIysz1CNLj8ulw5+0z9Up5ABMetBhQ5Nsjld+UiaF/MXW/c5EAlYstADqonlSzRS3wRFpgVOvEDYPBmVsmgrNv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXMZ+ZMl; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso1855561eec.0
        for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774691308; x=1775296108; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRlWsjp96tD6U6Z/Cd/j4p1pGmRJaWjFo7e47fa1C/A=;
        b=eXMZ+ZMl7sw5pk8rITM/ZHRIW9fG4x2xSaxYstxM0qXmmO/yTNlFRkkgItaLMBeox0
         H+1Bd/yh69vGmLbimCFPCigBbHa8r2/vQyAdo0VfRDRixMP/yGI0zLBt0BurAe171Fwg
         C+wTfN00pdxz5HxD6Tla7u5Cd55JzGTOz9k0bLJ7bZiH+TjA5vM9TnWr91zAYbWlDvis
         32U9bvjqzKhNKEgClnHAXdCR0+7rG60BNBvNu/Z1B/UnAplEHsyPU8f3g/vB5Wz5qSpr
         eaf/OCuNWHyFdQxxE4iFmrz/D5ope+bY4ix0qlAGWIhIIPRDRz0xOaPjgVaXjw2zT0y4
         +o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774691308; x=1775296108;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRlWsjp96tD6U6Z/Cd/j4p1pGmRJaWjFo7e47fa1C/A=;
        b=MwJZ2BP0Bhf/UxD1bLgUrWUEgB0L4FzE4Lqu/zNyeXa0n70XrqKgstCc3Dc6azzLxS
         X2KcsrXVgwYAvs89qpTHSogwJINkNJjU7bZ3BzkaCdzg2dxKjwgbeZwSf5KKqxTcJYpW
         /Kf4nas+ab2Z994O+Uvcc+JNL7ZyN52aYkRsX+kjqNeto+FcjDHT4FPsXeTjHPI4pLOh
         5u6OdAS52w9YWg9hm+SueNTG9PLUKeMr457JNLt/uHREoHIQRfQRWGsOmFI4qA1Yas43
         sRTWzt7f6ifvn9TdCZm2P6adGVbf6OHbGlohu7zTMGVv/EnwjTKnsgMXPyR5umYkjyOR
         PShQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQk1TC3Z7rtG/E+OUKVStXvKRHozRPmuGlh4bITFasT2oH1MCDpJlAml+janbASkkoVk0KaPWJqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uSKTkVL2/vl04lVrHsAR4RtAOm6IDPjTac5fpUCNRaBNdSYX
	ikC0SdNhPZAI98M3VO5gfgzZIl5Zv8dvUobmopZbyekstw8UKepsSqgQydTkZFLIha8=
X-Gm-Gg: ATEYQzyOlLJq0uJbFv5kwC2ovm/chGptp27dttO1EZOR92EZcTiRE3nh7wxvlRtNVB2
	5Y/tRontgcsr2+JEdZvgrTpq9pBAW7FOwusJkCo4fUjNaK13RVWw/U8v23zt7zqFrNYsSaNx2L1
	DOqOU5p0gm7PTLBMVFebcDBnvwAbFYMTNlRQP7on6+jaujfhA03w0KMy7JIyUO5xY5Gn8w8w/mL
	bfexUduN5XrGWpDoGLOX/qygYc8gKKIOOf+oqUw+u9nDf20sXOvE1UbDxocOniI+mWXaA+wsFQX
	GKmx5cKfuBiJr5oqns1tj9DAclRb2kkrYImamjRE83JoL2ahMHxbp2dWNxWoFrEGXV7glUkXdZH
	uNK4R/yBB4/MVyBoMjRNtIttO56pl7QN1Q5DR1zxyAKCGxntaus3jtlP2RajxIxWqRGAejESwFs
	Dp6fT5SIqJ+bxgc6UQICviEmlenJU=
X-Received: by 2002:a05:7300:fb8b:b0:2be:9c19:b34b with SMTP id 5a478bee46e88-2c186dd2a0amr2428508eec.4.1774691307454;
        Sat, 28 Mar 2026 02:48:27 -0700 (PDT)
Received: from localhost ([104.28.227.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda147sm1742844eec.5.2026.03.28.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:48:26 -0700 (PDT)
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
Date: Sat, 28 Mar 2026 17:48:24 +0800
Message-Id: <DHEBKA3QHPUT.2A9BJLPBXGQWG@linux.spacemit.com>
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
 <20260327-silkworm-of-algebraic-aurora-e9bd1c@quoll>
In-Reply-To: <20260327-silkworm-of-algebraic-aurora-e9bd1c@quoll>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9703-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 8409334DF7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Mar 27, 2026 at 3:28 PM CST, Krzysztof Kozlowski wrote:
> On Thu, Mar 26, 2026 at 04:17:16PM +0800, Troy Mitchell wrote:
>> From: Guodong Xu <guodong@riscstar.com>
>>=20
>> Add the DMA request numbers for non-secure peripherals of the K1 SoC
>> from SpacemiT.
>>=20
>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> ---
>>  include/dt-bindings/dma/k1-pdma.h | 56 ++++++++++++++++++++++++++++++++=
+++++++
>
> Also, this is not a separate commit.
Could you please clarify? This patch already contains only a single file
(include/dt-bindings/dma/k3-pdma.h).

                                    - Troy


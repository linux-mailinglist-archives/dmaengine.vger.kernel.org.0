Return-Path: <dmaengine+bounces-9704-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DZRB+qmx2mraAUAu9opvQ
	(envelope-from <dmaengine+bounces-9704-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 11:01:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B899B34E014
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 11:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C4E303B4EB
	for <lists+dmaengine@lfdr.de>; Sat, 28 Mar 2026 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559F3793C3;
	Sat, 28 Mar 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlhYebPa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8C13DBA0
	for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774691926; cv=none; b=HH1Q/P6n3TKbpkGRdHKAbWasAqgB6dV5v5R3lOGQP/F66i7w/v0K+3pUMzrfWS0yi6pRNeRFJnR3XpcqwzzwTFTtOvM15qoLKr4zEbkoPSkUxrDZSAGc7frI4x6IvlybHSuq0Dp+R/ih05bz4FAyu7vnPJMvlwJM4JWckGetPWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774691926; c=relaxed/simple;
	bh=b3JlCC4tL2Tz58FKwg2YL+SyAtOwXrfA/gsgi5WMt/A=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=iNm2Y1/ViKqTfShLy+KU2t629QmHo4MkfLhOPmZeEQVozvEdCciPVnpFqkpqpzixesgWfFkwuHYWAFQajZ7nmXUmsyQ6lEv1b+Iat04xxyp1DHA+AerkBmilF4OGGhDAmyqYmqwwEXfZ8UvxoWVMcM6SJu9mk1sEHEuYoEeZ3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlhYebPa; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2c0c955a481so3808158eec.1
        for <dmaengine@vger.kernel.org>; Sat, 28 Mar 2026 02:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774691923; x=1775296723; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPZRgmhGXKGLV4+N3md+ZOqvfZ5oB0BV4k3AKJQbhLw=;
        b=hlhYebPa5oD866bhGrd/E9DOI4xLPqqIBTNB58MI6CdiLe3RE62TMwDKXlT5JD9JHz
         616BnPap7CdTVnFhBgz1vNAQGISSEC6UKbM+tOLvrRlFVcbzBcrI4cKky7sUu2qgJ4sX
         esb+fG8/zEpOtMtAeSfw2QmIMue8UJ7bZmIBGfob3rD6Xv3MJ21axcBoS2W5kSerVQsE
         tfEGaebsgJnsUaKRNCmsXAcsz2vRhOYZP4/0+OcB/+t+DV0zUUDuXDPuQFc5W/jLyaIU
         yVE+fCtnWhzPC8ODrhs8bDg97Pn1/4nAx38AKFL8cWIQjWzg4YCemqayURr4y+W/0avQ
         5OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774691923; x=1775296723;
        h=in-reply-to:references:to:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPZRgmhGXKGLV4+N3md+ZOqvfZ5oB0BV4k3AKJQbhLw=;
        b=HVQGhYp8XpuM58mReOumRyYy+BRgu7IfdhR/mwKSbln6jdoju19cBQBfE+w/rzJVKj
         bBsFoBzh2zitm0p2ktFXR/AIg5nETE/iCqIzK3CIpe3KnvwqgnMAdjUht5GtaGCrrucs
         BVrxCJo+YdJU/2IIeQTyu7XeVhu/2NmsWuwyL5b0ZhtMhrf3AOjcWftBs0kI8ey7AwtX
         M9ARU+mhH+dDzTq0cD6Vkt0UXfVag1YnwkJBIo4HJ2JXuujuwZu15aXDVKOo7eiIHcBV
         kInlQB+FqJuvU41SwDg6OMJe3LmxkZ0odGx9WAX18kF551VWMA9fgYjoU2qihKOETlc9
         M88Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0D3VWFw90UtQtMcnQXMqV1EP8DTdvWfyFl+wQspdBkBTKcARY8IpNEd0F+C5h6IxiBvLgBdaUV9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qk7uAcqme3UOSgeMMJyGkPE4Xo0BEKVDPiPs4ZuPEjBH48V5
	qa5ihPUJsVmxIbAJg/xL7qC95FPfP/V++gFVIgdhcUlQzNMWnN5ve9mu3xXz6C3nTLI=
X-Gm-Gg: ATEYQzxXAYWz9UY4Pho5Vtdro/hdQxoAW4cjFabCovqpFQ0pD3vq9mqTUxQR7g9cuGz
	ras4M33Cs4Jvi1BBEgympXY1NEIhX7fSVzJka58fB4NkdK2pvlRVmfDwNDGd6jijzp4rN8/adK7
	oVcOk9EXf+vIcv5o50GOSc1+qqr2YNdAGsdQORjg9IOKDE56vxwI3UzIJ+foVMcKQOVGevhbNLz
	omHMX9wB4HNVkc4BNQYdtgsNYF8sHvhQMrKM5W/Fwc61oLzgpL43shV4Fa23268Xx+RVoA7extH
	xR3MAkgOApTaErWBrupv1+tzbuGxuR4R+xLCj6dnir200a4S57JoPnKxTZIJU9drI3yhf3rX9ew
	vtbE4vd0oxApZv0F3zNz8QjbS2QbCxK6Can2GDzbmpAD6ShJTh9IeagWAPrP0lzengXkNcWOa6o
	5k4mn5xeH1e+uJyhaDz4WvJDih56Q=
X-Received: by 2002:a05:7022:b98:b0:127:33e0:ea33 with SMTP id a92af1059eb24-12ab28e4da2mr3105409c88.22.1774691922629;
        Sat, 28 Mar 2026 02:58:42 -0700 (PDT)
Received: from localhost ([104.28.227.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c79722e0sm1866524eec.31.2026.03.28.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:58:42 -0700 (PDT)
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
Date: Sat, 28 Mar 2026 17:58:39 +0800
Message-Id: <DHEBS4TLJV5W.3AO0UY2JXWAFE@linux.spacemit.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou"
 <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan"
 <dlan@kernel.org>, "Vinod Koul" <vkoul@kernel.org>, "Frank Li"
 <Frank.Li@kernel.org>, "Guodong Xu" <guodong@riscstar.com>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <dmaengine@vger.kernel.org>, <linux-clk@vger.kernel.org>, "liyeshan"
 <yeshan.li@spacemit.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: dmaengine: Add SpacemiT K3 DMA
 request definitions
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260326-k3-pdma-v2-0-ca94ca7bb595@linux.spacemit.com>
 <20260326-k3-pdma-v2-3-ca94ca7bb595@linux.spacemit.com>
 <20260327-granite-giraffe-of-infinity-ff49a3@quoll>
In-Reply-To: <20260327-granite-giraffe-of-infinity-ff49a3@quoll>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9704-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spacemit.com:email,riscstar.com:email]
X-Rspamd-Queue-Id: B899B34E014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri Mar 27, 2026 at 3:30 PM CST, Krzysztof Kozlowski wrote:
> On Thu, Mar 26, 2026 at 04:17:18PM +0800, Troy Mitchell wrote:
>> From: liyeshan <yeshan.li@spacemit.com>
>>=20
>> Add device tree binding header for SpacemiT k3 DMA request numbers. This
>
> Why?
The DMA request mappings are hardware-hardwired and differ between the K1 a=
nd K3 SoCs.
Therefore, separate header files are required to define these unique consta=
nts for each
platform to ensure correct DMA channel allocation in the device tree.
>
>> defines the DMA request mapping for non-secure peripherals including UAR=
T,
>> I2C, SSP/SPI, CAN, and QSPI.
>>=20
>> Signed-off-by: liyeshan <yeshan.li@spacemit.com>
>
> Name looks close to login name?
I will contact her and confirm.
>
>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> ---
>>  include/dt-bindings/dma/k3-pdma.h | 83 ++++++++++++++++++++++++++++++++=
+++++++
>
> I am already confused what is happening in this patchset - so which
> device are you adding? K1 or K3?
Aside from this K1-related patch, the rest of the series focuses on adding =
support for
the K3 SoC. I included the K1 header because I noticed it was missing in th=
e upstream
tree while working on the K3 support.

It seems my attempt to 'clean up' K1 while adding K3 has caused unnecessary=
 confusion.
Would you prefer me to remove the K1 patch from this series and submit it a=
s a separate
patch?

                                    - Troy


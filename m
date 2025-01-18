Return-Path: <dmaengine+bounces-4155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D779EA15E16
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 17:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBEF7A2EBC
	for <lists+dmaengine@lfdr.de>; Sat, 18 Jan 2025 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EFC190676;
	Sat, 18 Jan 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMPQn0dN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9615CD78;
	Sat, 18 Jan 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737218006; cv=none; b=E6XQNviTZh24k3wc5ilbdp5sB/DsdiBLBR/9vwJynTR2x1czmv4gNRtzOPW8PaZ+LKcjkeTnWynCJJYxDkMUK0VxlsNJLtZfykosrTc69Uq9AjNfz2BD5YNuweTkCOmZcpgkRtN22/k39FbKWKs7itKSHkfz+7+GZbF8bSOW7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737218006; c=relaxed/simple;
	bh=N4WKOAPatm/OOVk7jJmgkjomTo8rCT0Ib92cgaZHAIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJZFmuv/LBN/1JJ554TfXU/E1xHYZx4bXisempoJt2SHy4eLT3edsDt6DEUQ8yicNgKGiwG+8DM6qbwWaSy5bWvo2w527KY1dHDA7zBwF2RjwfN8hCRLvBn56pET0J3K20eN3CKc1cxVMJQO3lfz2jj0mf5v7uiNJDKsYAf0wRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMPQn0dN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2164b662090so58271295ad.1;
        Sat, 18 Jan 2025 08:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737218004; x=1737822804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8mEEkakGykScFNyZ0WPlZb8FWyU5Ac0gzQtTbrAz/U=;
        b=fMPQn0dNfcZPjo1e88Zia4SSJe+oef62ds8fI8k2uaTGabZED3hJxcARRxtaKckqx8
         Z2opDC7PKPTZvoUhtErI/4yKQETyaKOCwcbqTla+VPETUw0CZCN+0jzDsns066zirP2f
         ZoAnxh6JJc0h4/iThJBe4n/TRhBzSXD9x56zLfo/qpA26pC3S5hSV6pM6JXGxOWm300M
         MbH1tq8nSQJeYqHeI0PBSM3W4bgRJB/nWIMP+1B3G1iMaXKutFl6E75vTpxU21H6sSip
         MB1NMJYQSstDudee+1lnG7qZ1fhxR0O5Ii0YYUpHWT7lmRtCWnp7rjBNSiWDAcKd7Lem
         JY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737218004; x=1737822804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8mEEkakGykScFNyZ0WPlZb8FWyU5Ac0gzQtTbrAz/U=;
        b=XRLq4e9wCHk+67lkLn2x1zttNWX3pN7b7LHydbXFhIvInsgTcR0NMyBw1MKBast/9r
         CK6fvYU7YZFYb64lVEv/gvFnArvVoLksLHiTIE5S+y7rDi7ck9AgxWLCSqrang3HdcMM
         gf8eEVzETd6ZeUYqR29VS8or8kq/2WB3sY/cerwVSAzxtlEFRv0oIq5ipgstJz9M+mKh
         mKv00MpI4sIir36kvrKSdrae5rob3fepA3SHtqf27vyjcPM3/HFVmqhAP59zkszPOZ+n
         oKVeyNZIvKr3so+ZACZEF+6FpYlWSBOyypQqHJU3wPOjpCJ5wKQdZyJtX/WOgrQpkcqy
         pZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCUo/Gebds/MqBAarDYiyNtVSaA42k97x16OSbcorYxvShzNPhQhJXjn0iMAcK4RG0xUmUVKAugiTcBwurS7@vger.kernel.org, AJvYcCVWgV5dq2AEBjRv1si9n6NFIhL9S/Ccxwir1I8r0T80C9u51j0IARjrZYpsN4Bc+VYa1Y3K1FmYedDnESI=@vger.kernel.org, AJvYcCWPSD3R+LOVO3Fo1QYO2f1rK9pmPbauXRVp7tYg7D/vAawIT/FW/+h88EffVihLE8iVk/QW2KhmFUw+@vger.kernel.org, AJvYcCXsjKJzMU44AXae7leXk1y0GDY43taf4cswEw5acqqWBS8rw0+q2WLsuWWze60NZhfA0P39SV1bp4e5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzvx98RKGK71KdXPrqmNBv+oKbCd3Z+t4PsHgBJZt7k+NK3U5z
	JLQKpQYaSVBqREQz0lbbntlDInAfLPnhwjCspHpMdbg++JriXj0UoVTFVg==
X-Gm-Gg: ASbGncuBa1pJ1fp0Nrc/WNyOYMRw3JzEX/ZANk7Qa1tThtKZHSeTQ/QcIcTyos4Aq36
	h6L/299bSrMyRJpD5fLCh1r4uAqRvsl9sX0mjqeH2vJsMfXkHzJjAfovI45lV8k0VdQTd7xPMI1
	9H4fmWTtvt/Z1vjb0WyL8AfEVJvSlnVVkpnx2kiEjJPkMGluZebQy3eCStl0B5aYAZhHP2eORO/
	3fE6psm04llevKJV6Q342vZbifbgzjY8au4opKoPho4LpvFPXwr3h5t1aZPkL46r4L+1oHSTAu3
	Nor7gCI=
X-Google-Smtp-Source: AGHT+IHEi4wmUrSoEgk5WEe5KpbsQvX76CpDRoF3M4upcFuoYFKc+Mt2Fud5TtYe9vt9uTP+GMo04Q==
X-Received: by 2002:a05:6a20:3d89:b0:1db:d738:f2ff with SMTP id adf61e73a8af0-1eb2144d6e7mr12815751637.2.1737218003968;
        Sat, 18 Jan 2025 08:33:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9b9ae0sm4040705b3a.93.2025.01.18.08.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 08:33:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 Jan 2025 08:33:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, spujar@nvidia.com
Subject: Re: [PATCH v2 RESEND 2/2] dmaengine: tegra210-adma: Support channel
 page
Message-ID: <77e9f23a-60e2-442c-9981-319fc650979a@roeck-us.net>
References: <20241217074358.340180-1-mkumard@nvidia.com>
 <20241217074358.340180-3-mkumard@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217074358.340180-3-mkumard@nvidia.com>

Hi,

On Tue, Dec 17, 2024 at 01:13:58PM +0530, Mohan Kumar D wrote:
> Multiple ADMA Channel page hardware support has been
> added from TEGRA186 and onwards.
> 
> - Add support in the tegra adma driver to handle selective
>   channel page usage
> - Make global register programming optional
> 
> Signed-off-by: Mohan Kumar D <mkumard@nvidia.com>

This patch triggers a build failure when trying to build i386:all{yes,mod}config.

x86_64-linux-ld: drivers/dma/tegra210-adma.o: in function `tegra_adma_probe':
tegra210-adma.c:(.text+0x1322): undefined reference to `__udivdi3'

Bisect log is attached for reference.

Problem is

> +		if (res_base) {
> +			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;

->start is phys_addr_t which can be a 64-bit pointer on 32-bit systems,
making this a 64-bit divide operation.

Bisect log and a possible fix are attached for reference. I am not sure
though if the suggested fix is correct/complete since page_no might
overflow on such systems. It should possibly be a phys_addr_t, but that
is unsigned so the subsequent negative check would not work.

Guenter

---
# bad: [0907e7fb35756464aa34c35d6abb02998418164b] Add linux-next specific files for 20250117
# good: [5bc55a333a2f7316b58edc7573e8e893f7acb532] Linux 6.13-rc7
git bisect start 'HEAD' 'v6.13-rc7'
# good: [195cedf4deacf84167c32b866ceac1cf4a16df15] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 195cedf4deacf84167c32b866ceac1cf4a16df15
# good: [01c19ecf34e1713365346f932011facd7d2d2bc6] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect good 01c19ecf34e1713365346f932011facd7d2d2bc6
# good: [7fac8eef32d7735a3b01d08f2c98d5e6eaf254da] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect good 7fac8eef32d7735a3b01d08f2c98d5e6eaf254da
# bad: [24c55da105e9a641fa77c8d8efbf92472a18bf4e] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect bad 24c55da105e9a641fa77c8d8efbf92472a18bf4e
# good: [73656a6ab6d428102eb5aaa9599b5fcba4a2501f] intel_th: core: fix kernel-doc warnings
git bisect good 73656a6ab6d428102eb5aaa9599b5fcba4a2501f
# good: [b995a104a0aa1d6b90ea4ba3110e657ae9e83213] Merge branch 'tty-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
git bisect good b995a104a0aa1d6b90ea4ba3110e657ae9e83213
# good: [002c855847f718e12879808404dc8375207012dd] Merge branch 'next' of git://github.com/awilliam/linux-vfio.git
git bisect good 002c855847f718e12879808404dc8375207012dd
# bad: [54e09c8e2d3b0b7d603a64368fa49fe2a8031dd1] dt-bindings: dma: st-stm32-dmamux: Add description for dma-cell values
git bisect bad 54e09c8e2d3b0b7d603a64368fa49fe2a8031dd1
# good: [9d880452fb3edc4645e28264381ce35606fb1b19] dmaengine: amd: qdma: make read-only arrays h2c_types and c2h_types static const
git bisect good 9d880452fb3edc4645e28264381ce35606fb1b19
# good: [775363772f5e72b984a883e22d510fec5357477a] dt-bindings: dma: ti: k3-bcdma: Add J722S CSI BCDMA
git bisect good 775363772f5e72b984a883e22d510fec5357477a
# bad: [36d8cbd661c48f4c18eeb414146ec68a71fd644f] Merge branch 'fixes' into next
git bisect bad 36d8cbd661c48f4c18eeb414146ec68a71fd644f
# good: [762b37fc6ae2af0c7ddf36556fe7427575e9c759] dt-bindings: dma: Support channel page to nvidia,tegra210-adma
git bisect good 762b37fc6ae2af0c7ddf36556fe7427575e9c759
# bad: [9602a843cb3a16df8930eb9b046aa7aeb769521b] dmaengine: bcm2835-dma: Prevent suspend if DMA channel is busy
git bisect bad 9602a843cb3a16df8930eb9b046aa7aeb769521b
# bad: [68811c928f88828f188656dd3c9c184eeec2ce86] dmaengine: tegra210-adma: Support channel page
git bisect bad 68811c928f88828f188656dd3c9c184eeec2ce86
# first bad commit: [68811c928f88828f188656dd3c9c184eeec2ce86] dmaengine: tegra210-adma: Support channel page

---
diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index 6896da8ac7ef..1de3d84d3b7c 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -914,7 +914,7 @@ static int tegra_adma_probe(struct platform_device *pdev)
 
 		res_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "global");
 		if (res_base) {
-			page_no = (res_page->start - res_base->start) / cdata->ch_base_offset;
+			page_no = div_s64(res_page->start - res_base->start, cdata->ch_base_offset);
 			if (page_no <= 0)
 				return -EINVAL;
 			tdma->ch_page_no = page_no - 1;


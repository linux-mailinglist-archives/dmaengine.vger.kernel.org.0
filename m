Return-Path: <dmaengine+bounces-6043-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5395AB278C3
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 08:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A21CE6EB1
	for <lists+dmaengine@lfdr.de>; Fri, 15 Aug 2025 06:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64AA253B5C;
	Fri, 15 Aug 2025 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="AN4l+0qC"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988A2192F9;
	Fri, 15 Aug 2025 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237914; cv=none; b=b+uny3MS/Q55CRA6M4pe5EaaA+LxzS2biB/9QlIF+rkQdrBHcRwIptxp4O0XC855AFAqMIu134lcNM3YX8P3+h3B2BPP5RTY4T+9QReGtLPKZLcICLX2gk1DaFwDbFZq0m9afsgQ9E83LJFuapNB8PTko9EPCXJTNMlayeaDCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237914; c=relaxed/simple;
	bh=sEAPkLK/x86g1f+WwcdgXDEqeVxbXUsDWRXIIu529Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ6nDNpLGwE7MgdyHGBp4bEYsfQjnPjonpnDw9gca4z7jYbA1044pA/YfWiKmaknvcgZfl7GwD7ecOSa0N/sJLOpUqzQgsS4H3b6kcsspTq9OafXqkIUWg/i7KQJeihkfaxdiHfEPgdLX50gRJ8sfQD0gkescdnXV/9OXiRznK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=AN4l+0qC; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755237722;
	bh=x1N3D6/VxKcATBuZmB7CNiYmp7p5XE6OMaGosmRFbxU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=AN4l+0qCzp1RzPoeXXfPENTHMbSIMEj0BshDNEzAf6oQRM/94Sge18g2i+icH3Vu+
	 I3fiIfLZw02VXhL1b+qzNq+Y+sSZjZ2nDyaIwNLl8gHkKzr9SczmfFXZlIBIVdC722
	 ywAEC6pZzwdnYrAkQsctFaAtv5LhxHTYaUUuJbl0=
X-QQ-mid: zesmtpgz1t1755237720taae2885a
X-QQ-Originating-IP: Awd2VcLVbmDqB933ZLJHIsPxY4Y//B/JRsothqN1eyI=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 14:01:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2894032038564909273
EX-QQ-RecipientCnt: 20
Date: Fri, 15 Aug 2025 14:01:57 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Guodong Xu <guodong@riscstar.com>, Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v4 6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
Message-ID: <34485B93B03EAD10+aJ7NVbe8aqjWBFd-@LT-Guozexi>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
 <20250815-working_dma_0701_v2-v4-6-62145ab6ea30@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-working_dma_0701_v2-v4-6-62145ab6ea30@riscstar.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MsXD3WsHXmxXiGeeLocpRz3B53KmNsAf5gcMA8ombNJDntx/8yfeD8tY
	AwPiwgJDg9Tx0stKB8oIL4gyH8aPI5B6xAp2tBggtU43exhAUiOwYhox/+reWl28BlnOGCA
	B2wX+lSrTERodhn7X9OdPVnH39WZ+JS+bEZSf85TaHEhAtSNPagKE0vPDwnl+28BGUD8Dfy
	nR4ZMWcHE+5SLji3DK+7n0a/AlVeHp4CSwEFfZsvt15t4WS1zfDagZxiSDOoJILvLQqIO29
	01vYky6jFsFlM5Gn1AO733+l4nkC9G1awYecFBhe2j+hsWZSWKWAySLd835LPYPObMHAQg8
	gd2+JHNqKF2fu5QCDYPC4K0gUsR2phUvKszjl5K+XmD1Teq4bjwVC5Bm/MH1ZJSc7idiRBG
	IoBhL/nFHVjg0ZN7zhgnd7kpjZlSx8QvWwhBV5Tb4rXXgj5Ow14UkMi0bL9CqbBhSvhM1pB
	Odqs9Tpw7FqDrz96HJ2ZXHpM5skmnyKXMIBlRjxmgo0+Vka+pgnDiYDkta0lHdtCidSNweJ
	T6EjtCm4vKJoDOxkIELHCy9/PJXQjpWMz+q9tY08rP7FYFiJSgNsTeM3YXmxMspTn9vSuSc
	SLJp+L7nIfnnEz3UWQHPgG1Zt4eSV0SLv3uT7KCyWzoZZ2uAcwpQVqC+bIbkF4teNhJ1x6U
	m8jblalvB4EECF2bIA5WOHt0O1eptyjq+l1XRLUQZ7BiA6pmOR3qYL/zHHnRRTtE4AWu0Py
	iMWExMVDCZWUvR1rBC+UrYUyAnxa8/KqsX1vVQRIrMSN6FD1DdvCgFA5CoGBsZT1v6pMR6X
	SsRMlC3sa6IowX4VWqh5Y3ZW/CZEB7/73focYwCRpZJlpUCOBAQN6ye1a13Q7ql2m1OysEp
	XRrht7cjdDC0ulo0ZVD0DQs6jtKUKcD3PPlxcZo6fg6DkTlfAgpv5kC5izQ+D1QAfQfOSiz
	V164n//JOjbyWQrzUPmpovAqrHZxB8pnfr4rI/JqsoCihAglGDdn+QUZgkjTZk14ZXMRuUd
	eyEkuaypuzkVQyvTAK4toTKtnHtZ+MlvrMzuF7WkR+Kub2y6GrL9SkElthtsbkq36VsDXlg
	CWbO39OpOp9/JAVrdTbHVVXHBpVZahC1G+seIqpp9rvtR6UX5tvSXWFuBGyRJsa5V9qjPcC
	wxt5
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Thanks.

Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

On Fri, Aug 15, 2025 at 01:16:28PM +0800, Guodong Xu wrote:
> Add PDMA dma-controller node under dma_bus for SpacemiT K1 SoC.
> 
> The PDMA node is marked as disabled by default, allowing board-specific
> device trees to enable it as needed.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v4:
> - rename the node from pdma0 to pdma
> - for consistnecy, put the "interrupts" after "clocks" and "resets"
> v3:
> - adjust pdma0 position, ordering by device address
> - update properties according to the newly created schema binding
> v2:
> - Updated the compatible string.
> - Rebased. Part of the changes in v1 is now in this patchset:
>    - "riscv: dts: spacemit: Add DMA translation buses for K1"
>    - Link: https://lore.kernel.org/all/20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn/
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index abde8bb07c95c5a745736a2dd6f0c0e0d7c696e4..861f0fe18083fa158da51bd3be2808609f6233f4 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -660,6 +660,17 @@ dma-bus {
>  			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
>  				     <0x1 0x00000000 0x1 0x80000000 0x3 0x00000000>;
>  
> +			pdma: dma-controller@d4000000 {
> +				compatible = "spacemit,k1-pdma";
> +				reg = <0x0 0xd4000000 0x0 0x4000>;
> +				clocks = <&syscon_apmu CLK_DMA>;
> +				resets = <&syscon_apmu RESET_DMA>;
> +				interrupts = <72>;
> +				dma-channels = <16>;
> +				#dma-cells= <1>;
> +				status = "disabled";
> +			};
> +
>  			uart0: serial@d4017000 {
>  				compatible = "spacemit,k1-uart",
>  					     "intel,xscale-uart";
> 
> -- 
> 2.43.0
> 
> 


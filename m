Return-Path: <dmaengine+bounces-4539-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0CEA3CC4C
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 23:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFD9188893F
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9EF2586F1;
	Wed, 19 Feb 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYgVFYnc"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72F255E33;
	Wed, 19 Feb 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004061; cv=none; b=QvcJdoABiCFUmIaaS4UCW3xCmYmGFnKpzS5lJJD0mi0MxOpNfCs08zOR/2XA0fN0UoCsl5f3IZ0OvMdVgl/6pQzqqItcqtTJ9IVwWDrQ/vsTXaqdeIk4Jh0quqIQ2een/7+oKXP3XRixFW4Z4wDwDipEoVofsKWxdxMJb2RsQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004061; c=relaxed/simple;
	bh=oNSknPE2NI2RnvMQgqpZdnjt+G1s3GYul1BLdUi6ryg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Feuv/DMKb6MKWEY1wvbnlNcPm7ff5GF8BYotDaRfuG5XGHPPhNtgke51iKKtkXv7p8/erY6XL3Yp3SuOg7qije3vwOGYAd27ykqWOo5XaBmlG4MH3CAKIU4REayR3gC11+XgyVrFkE4imr9olvczAfklUG8ZKtuILf/N3Oc6oKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYgVFYnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A012FC4CED1;
	Wed, 19 Feb 2025 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004060;
	bh=oNSknPE2NI2RnvMQgqpZdnjt+G1s3GYul1BLdUi6ryg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYgVFYncWMZron/LK2kkTgBsnEaG/nJw516UKoh0/uyh4ODVkCDRKngg0xOp9LqPl
	 ykdhiz0qPZcYsaLAke6ct7k3QKD5fC/t6efA5RPm8J1+H3zelKaKAbYRMyAkiViWag
	 ziohIv8EIcVUlV3JVdEbV/S4gY11MZCDt+W2LJiE4v1Z2C572DQR8YuZBcEGWMADFD
	 LWb7klY6ximxjK7nrS03IPdzwXU0aTLAGF3Gg5A/9JPS2+tg3thlcVJnX5lGbjqUpA
	 QZrQbfRhBxuLw2NJSSQ/vaPEOjWmEVBTs/IymrwyCHsFiZXPtjf5xmJPvb9Bm14V64
	 fVZ+lL3dyozUQ==
Date: Wed, 19 Feb 2025 16:27:39 -0600
From: Rob Herring <robh@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 7/8] dt-bindings: dma: qcom: bam-dma: Add missing
 required properties
Message-ID: <20250219222739.GA3078392-robh@kernel.org>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-7-f560889e65d8@linaro.org>
 <22ce4c8d-1f3b-42c9-b588-b7d74812f7b0@oss.qualcomm.com>
 <Z6231bBqNhA2M4Ap@linaro.org>
 <d674d626-e6a3-4683-8f45-81b09200849f@oss.qualcomm.com>
 <Z64OKcj9Ns1NkUea@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64OKcj9Ns1NkUea@linaro.org>

On Thu, Feb 13, 2025 at 04:22:17PM +0100, Stephan Gerhold wrote:
> On Thu, Feb 13, 2025 at 03:00:00PM +0100, Konrad Dybcio wrote:
> > On 13.02.2025 10:13 AM, Stephan Gerhold wrote:
> > > On Wed, Feb 12, 2025 at 10:01:59PM +0100, Konrad Dybcio wrote:
> > >> On 12.02.2025 6:03 PM, Stephan Gerhold wrote:
> > >>> num-channels and qcom,num-ees are required when there are no clocks
> > >>> specified in the device tree, because we have no reliable way to read them
> > >>> from the hardware registers if we cannot ensure the BAM hardware is up when
> > >>> the device is being probed.
> > >>>
> > >>> This has often been forgotten when adding new SoC device trees, so make
> > >>> this clear by describing this requirement in the schema.
> > >>>
> > >>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > >>> ---
> > >>>  Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 4 ++++
> > >>>  1 file changed, 4 insertions(+)
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > >>> index 3ad0d9b1fbc5e4f83dd316d1ad79773c288748ba..5f7e7763615578717651014cfd52745ea2132115 100644
> > >>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > >>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > >>> @@ -90,8 +90,12 @@ required:
> > >>>  anyOf:
> > >>>    - required:
> > >>>        - qcom,powered-remotely
> > >>> +      - num-channels
> > >>> +      - qcom,num-ees
> > >>>    - required:
> > >>>        - qcom,controlled-remotely
> > >>> +      - num-channels
> > >>> +      - qcom,num-ees
> > >>
> > >> I think I'd rather see these deprecated and add the clock everywhere..
> > >> Do we know which one we need to add on newer platforms? Or maybe it's
> > >> been transformed into an icc path?
> > > 
> > > This isn't feasible, there are too many different setups. Also often the
> > > BAM power management is tightly integrated into the consumer interface.
> > > To give a short excerpt (I'm sure there are even more obscure uses):
> > > 
> > >  - BLSP BAM (UART, I2C, SPI on older SoCs):
> > >     1. Enable GCC_BLSP_AHB_CLK
> > >     -> This is what the bam_dma driver supports currently.
> > > 
> > >  - Crypto BAM: Either
> > >     OR 1. Vote for single RPM clock
> > >     OR 1. Enable 3 separate clocks (CE, CE_AHB, CE_AXI)
> > >     OR 1. Vote dummy bandwidth for interconnect
> > > 
> > >  - BAM DMUX (WWAN on older SoCs):
> > >     1. Start modem firmware
> > >     2. Wait for BAM DMUX service to be up
> > >     3. Vote for power up via the BAM-DMUX-specific SMEM state
> > >     4. Hope the firmware agrees and brings up the BAM
> > > 
> > >  - SLIMbus BAM (audio on some SoCs):
> > >     1. Start ADSP firmware
> > >     2. Wait for QMI SLIMBUS service to be up via QRTR
> > >     3. Vote for power up via SLIMbus-specific QMI messages
> > >     4. Hope the firmware agrees and brings up the BAM
> > > 
> > > Especially for the last two, we can't implement support for those
> > > consumer-specific interfaces in the BAM driver. Implementing support for
> > > the 3 variants of the Crypto BAM would be possible, but it's honestly
> > > the least interesting use case of all these. It's not really clear why
> > > we are bothing with the crypto engine on newer SoCs at all, see e.g. [1].
> > > 
> > > [1]: https://lore.kernel.org/linux-arm-msm/20250118080604.GA721573@sol.localdomain/
> > > 
> > >> Reading back things from this piece of HW only to add it to DT to avoid
> > >> reading it later is a really messy solution.
> > > 
> > > In retrospect, it could have been cleaner to avoid describing the BAM as
> > > device node independent of the consumer. We wouldn't have this problem
> > > if the BAM driver would only probe when the consumer is already ready.
> > > 
> > > But I think specifying num-channels in the device tree is the cleanest
> > > way out of this mess. I have a second patch series ready that drops
> > > qcom,num-ees and validates the num-channels once it's safe reading from
> > > the BAM registers. That way, you just need one boot test to ensure the
> > > device tree description is really correct.
> > 
> > Thanks for the detailed explanation!
> > 
> > Do you think it could maybe make sense to expose a clock/power-domain
> > from the modem/adsp rproc and feed it to the DMUX / SLIM instances when
> > an appropriate ping arrives? This way we'd also defer probing the drivers
> > until the device is actually accessible.
> > 
> 
> Maybe, but that would result in a cyclic dependency between the DMA
> provider and consumer. E.g.
> 
> 	bam_dmux_dma: dma-controller@ {
> 		#dma-cells = <1>;
> 		power-domains = <&bam_dmux>;
> 	};
> 
> 	remoteproc@ {
> 		/* ... */
> 
> 		bam_dmux: bam-dmux {
> 			dmas = <&bam_dmux_dma 4>, <&bam_dmux_dma 5>;
> 			dma-names = "tx", "rx";
> 		};
> 	};
> 
> fw_devlink will likely get confused by that.

Why? We have a property to break cycles: post-init-providers

That doesn't work here?

Rob


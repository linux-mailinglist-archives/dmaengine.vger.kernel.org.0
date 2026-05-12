Return-Path: <dmaengine+bounces-10341-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFDGFNHyAmo9zAEAu9opvQ
	(envelope-from <dmaengine+bounces-10341-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 11:28:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4451DAFE
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 11:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D3B3021B0B
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B1F42EEDA;
	Tue, 12 May 2026 09:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0JSfZQZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47D3BBA07;
	Tue, 12 May 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577315; cv=none; b=P5nybtulD3GUdzTQrZu0q7aUKknbto9ZLo5PEAzY+gDq2bsEeQWmgLAsL9hdQPbNLnj/oEEzJYEziGrKaVFoEOpSwLf8HOgvi6NqS3dZb5KRKoM/jyysWkCgXTlUkQFPHS3TQyC3AFIgsRApQ3/jzBVA3smhny1FZLIDfDXXxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577315; c=relaxed/simple;
	bh=tQrx4ZRS7IpQ4Yeb3zvXcMC5gRyGgc0EqCTTskuD72c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKgZzyDBzBHcujWSJNoiWj6drNMCQT2e3zTyJCOfEPDPkGcYq8K7iot7dR7Y6f+fQk9PdBLx/4oz7F8jMzc/Az4VJywUZE5uEYz9NTDi2CNwaruNKcGk8xHCOxQ+k4wqWruGCxeuw3Umck3LTLz46AwZCXff9jvKMINpAN030V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0JSfZQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA8C2BCB0;
	Tue, 12 May 2026 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778577314;
	bh=tQrx4ZRS7IpQ4Yeb3zvXcMC5gRyGgc0EqCTTskuD72c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0JSfZQZpjD/Tvilt+ZydSoCODb9Cfdg9R/yccRDlcfaoqRM8iSMCNxRaMjr8pF/7
	 PxuXXBLtVyINXXEJr8VmMbnEE0/2uqGdkKSzC5ft2lBFgjHBi9yZiITxp1XcstcHE8
	 EK0wfXtuOs/5/GoVOCWIbJO9H5aWRYiL2sW/8mKhWqyNPtknH75fuBTGJanoB7tqpX
	 +cGkXvFkkkcFpNm7iZLpVnNQbTZqufS2LlzPV9BVyeUykqzjr9aaSWmCmrrMhNnzm9
	 IA1oPOljf0GEIfzjcMt4eZSfvURwoY6rIUz8dwJ6TrRoOWfY0pZEi/8r4DRSb4tS/f
	 A6nDUfzh5Gj5Q==
Date: Tue, 12 May 2026 11:15:12 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Heiko Stuebner <heiko@sntech.de>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Parvathi Pudi <parvathi@couthit.com>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	"Andrew F. Davis" <afd@ti.com>,
	Hussain Khaja <basharath@couthit.com>, Suman Anna <s-anna@ti.com>,
	Ben Levinsky <ben.levinsky@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Erwan Leray <erwan.leray@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Roger Quadros <rogerq@ti.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Consolidate "sram" property definition
Message-ID: <agLvoBCkUf_TN5b-@lore-desk>
References: <20260511165942.2774868-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DRGrXT3EJq+RYIF3"
Content-Disposition: inline
In-Reply-To: <20260511165942.2774868-1-robh@kernel.org>
X-Rspamd-Queue-Id: B7E4451DAFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10341-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,chipsnmedia.com,collabora.com,vanguardiasur.com.ar,sntech.de,foss.st.com,lunn.ch,davemloft.net,google.com,redhat.com,ti.com,couthit.com,linaro.org,baylibre.com,googlemail.com,amd.com,nbd.name,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[79];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Action: no action


--DRGrXT3EJq+RYIF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The "sram" property has become a de facto standard property, so create a
> common schema for it and drop all the duplicated definitions.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  .../imx/fsl,imx8qxp-dc-command-sequencer.yaml |  2 +-
>  .../devicetree/bindings/display/msm/gpu.yaml  |  6 +----
>  .../bindings/dma/stericsson,dma40.yaml        |  8 ++----
>  .../bindings/media/cnm,wave521c.yaml          |  2 +-
>  .../bindings/media/nxp,imx8-jpeg.yaml         |  6 ++---
>  .../bindings/media/rockchip,vdec.yaml         |  5 ++--
>  .../bindings/media/st,stm32-dcmi.yaml         |  6 ++---
>  .../devicetree/bindings/net/mediatek,net.yaml |  3 +--
>  .../bindings/net/ti,icssg-prueth.yaml         |  2 +-
>  .../bindings/net/ti,icssm-prueth.yaml         |  2 +-
>  .../remoteproc/amlogic,meson-mx-ao-arc.yaml   |  7 +----
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  |  8 ------
>  .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  |  8 ------
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         |  9 +------
>  .../devicetree/bindings/spi/st,stm32-spi.yaml | 10 +++----
>  .../bindings/sram/sram-consumer.yaml          | 26 +++++++++++++++++++
>  16 files changed, 48 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sram/sram-consumer.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc=
-command-sequencer.yaml b/Documentation/devicetree/bindings/display/imx/fsl=
,imx8qxp-dc-command-sequencer.yaml
> index 27118f4c0d28..fd095e5742c5 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-comman=
d-sequencer.yaml
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-comman=
d-sequencer.yaml
> @@ -41,7 +41,7 @@ properties:
>        - const: sw3
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description: phandle pointing to the mmio-sram device node
> =20
>  required:
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Doc=
umentation/devicetree/bindings/display/msm/gpu.yaml
> index 04b2328903ca..358759fad8dc 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
> @@ -84,13 +84,9 @@ properties:
>      maxItems: 64
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1
>      maxItems: 4
> -    items:
> -      maxItems: 1
> -    description: |
> -      phandles to one or more reserved on-chip SRAM regions.
> +    description:
>        phandle to the On Chip Memory (OCMEM) that's present on some a3xx =
and
>        a4xx Snapdragon SoCs. See
>        Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> diff --git a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml =
b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> index 607da11e7baa..d8f92838f4c9 100644
> --- a/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> +++ b/Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> @@ -136,13 +136,9 @@ properties:
>      maxItems: 1
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -    description: A phandle array with inner size 1 (no arg cells).
> -      First phandle is the LCPA (Logical Channel Parameter Address) memo=
ry.
> -      Second phandle is the  LCLA (Logical Channel Link base Address) me=
mory.
> -    maxItems: 2
>      items:
> -      maxItems: 1
> +      - description: LCPA (Logical Channel Parameter Address) memory.
> +      - description: LCLA (Logical Channel Link base Address) memory.
> =20
>    memcpy-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/=
Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> index 6a11c1d11fb5..6cd33dfd095d 100644
> --- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> +++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
> @@ -37,7 +37,7 @@ properties:
>      maxItems: 1
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
>        The VPU uses the SRAM to store some of the reference data instead =
of
>        storing it on DMA memory. It is mainly used for the purpose of red=
ucing
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b=
/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 18cc6315a821..6ba668aa633d 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -56,10 +56,10 @@ properties:
>      maxItems: 5               # Wrapper and 4 slots
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
> -      Optional phandle to a reserved on-chip SRAM regions. The SRAM can
> -      be used for descriptor storage, which may improve bus utilization.
> +      The SRAM can be used for descriptor storage, which may improve bus
> +      utilization.
> =20
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b=
/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> index 42022401d0ff..4f38a0ef29d8 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
> @@ -91,9 +91,8 @@ properties:
>      maxItems: 1
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: |
> -      phandle to a reserved on-chip SRAM regions.
> +    maxItems: 1
> +    description:
>        Some SoCs, like rk3588 provide on-chip SRAM to store temporary
>        buffers during decoding.
> =20
> diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml b=
/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> index d9fbb90b0977..7c2ddd27780f 100644
> --- a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> +++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> @@ -47,10 +47,10 @@ properties:
>      maxItems: 1
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
> -      phandle to a reserved SRAM region which is used as temporary
> -      storage memory between DMA and MDMA engines.
> +      SRAM region which is used as temporary storage memory between DMA =
and
> +      MDMA engines.
> =20
>    port:
>      $ref: /schemas/graph.yaml#/$defs/port-base
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Do=
cumentation/devicetree/bindings/net/mediatek,net.yaml
> index cc346946291a..6bbd83c6aaf7 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -67,8 +67,7 @@ properties:
>        - const: ppe
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: phandle to mmio SRAM
> +    maxItems: 1
> =20
>    mediatek,ethsys:
>      $ref: /schemas/types.yaml#/definitions/phandle
> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b=
/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> index c296e5711848..883033b19b8f 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
> @@ -21,7 +21,7 @@ properties:
>        - ti,am654-sr1-icssg-prueth  # for AM65x SoC family, SR1.0
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
>        phandle to MSMC SRAM node
> =20
> diff --git a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml b=
/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> index a98ad45ca66f..9370c43bc66a 100644
> --- a/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,icssm-prueth.yaml
> @@ -24,7 +24,7 @@ properties:
>        - ti,am3359-prueth   # for AM33x SoC family
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> +    maxItems: 1
>      description:
>        phandle to OCMC SRAM node
> =20
> diff --git a/Documentation/devicetree/bindings/remoteproc/amlogic,meson-m=
x-ao-arc.yaml b/Documentation/devicetree/bindings/remoteproc/amlogic,meson-=
mx-ao-arc.yaml
> index 76e8ca44906a..3f710433e937 100644
> --- a/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-ar=
c.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/amlogic,meson-mx-ao-ar=
c.yaml
> @@ -48,12 +48,7 @@ properties:
>      minItems: 1
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description:
> -      phandles to a reserved SRAM region which is used as the memory of
> -      the ARC core. The region should be defined as child nodes of the
> -      AHB SRAM node as per the generic bindings in
> -      Documentation/devicetree/bindings/sram/sram.yaml
> +    maxItems: 1
> =20
>    amlogic,secbus2:
>      $ref: /schemas/types.yaml#/definitions/phandle
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc=
=2Eyaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index b51bb863d759..8b1ed384ef22 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -75,16 +75,8 @@ properties:
>  # --------------------
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
>      minItems: 1
>      maxItems: 4
> -    items:
> -      maxItems: 1
> -    description: |
> -      phandles to one or more reserved on-chip SRAM regions. The regions
> -      should be defined as child nodes of the respective SRAM node, and
> -      should be defined as per the generic bindings in,
> -      Documentation/devicetree/bindings/sram/sram.yaml
> =20
>  allOf:
>    - if:
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc=
=2Eyaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> index 775e9b3a1938..14e6b2f817b3 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
> @@ -224,16 +224,8 @@ patternProperties:
>            at 0x0) or 0 (BTCM at 0x0), default value is 1 if omitted.
> =20
>        sram:
> -        $ref: /schemas/types.yaml#/definitions/phandle-array
>          minItems: 1
>          maxItems: 4
> -        items:
> -          maxItems: 1
> -        description: |
> -          phandles to one or more reserved on-chip SRAM regions. The reg=
ions
> -          should be defined as child nodes of the respective SRAM node, =
and
> -          should be defined as per the generic bindings in,
> -          Documentation/devicetree/bindings/sram/sram.yaml
> =20
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5f=
ss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.ya=
ml
> index ee63c03949c9..c7d5e58330d6 100644
> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> @@ -106,20 +106,13 @@ patternProperties:
>            - const: rx
> =20
>        sram:
> -        $ref: /schemas/types.yaml#/definitions/phandle-array
>          minItems: 1
>          maxItems: 8
> -        items:
> -          maxItems: 1
> -        description: |
> +        description:
>            phandles to one or more reserved on-chip SRAM regions. Other t=
han TCM,
>            the RPU can execute instructions and access data from the OCM =
memory,
>            the main DDR memory, and other system memories.
> =20
> -          The regions should be defined as child nodes of the respective=
 SRAM
> -          node, and should be defined as per the generic bindings in
> -          Documentation/devicetree/bindings/sram/sram.yaml
> -
>        memory-region:
>          description: |
>            List of phandles to the reserved memory regions associated wit=
h the
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Do=
cumentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index 472e92974714..6d7d595e4ab3 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -89,12 +89,10 @@ properties:
>        - const: rxm2m
> =20
>    sram:
> -    $ref: /schemas/types.yaml#/definitions/phandle
> -    description: |
> -      Phandles to a reserved SRAM region which is used as temporary
> -      storage memory between DMA and MDMA engines.
> -      The region should be defined as child node of the AHB SRAM node
> -      as per the generic bindings in Documentation/devicetree/bindings/s=
ram/sram.yaml
> +    maxItems: 1
> +    description:
> +      SRAM region which is used as temporary storage memory between DMA =
and
> +      MDMA engines.
> =20
>    power-domains:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sram/sram-consumer.yaml b/=
Documentation/devicetree/bindings/sram/sram-consumer.yaml
> new file mode 100644
> index 000000000000..f00087bd2879
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sram/sram-consumer.yaml
> @@ -0,0 +1,26 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sram/sram-consumer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SRAM Consumers
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +select: true
> +
> +properties:
> +  sram:
> +    description:
> +      Phandles to one or more reserved on-chip SRAM regions. The regions
> +      should be defined as child nodes of the respective SRAM node, and
> +      should be defined as per the generic bindings in,
> +      Documentation/devicetree/bindings/sram/sram.yaml
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1
> +
> +additionalProperties: true
> +...
> --=20
> 2.53.0
>=20

--DRGrXT3EJq+RYIF3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCagLvoAAKCRA6cBh0uS2t
rB3PAQDUyipx/50v+HQH37ZQgQgNXN+WyuErXdljPkPOAGPQXQEA5AF8C1BtXXr0
ThfwiDvqyao6viviV65dKTdINUDRXA4=
=S+zT
-----END PGP SIGNATURE-----

--DRGrXT3EJq+RYIF3--


Return-Path: <dmaengine+bounces-9821-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFNMMynlzWlVigYAu9opvQ
	(envelope-from <dmaengine+bounces-9821-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 05:40:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3571F38339B
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 05:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FFF300CE79
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C814352C51;
	Thu,  2 Apr 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnQz9Jcr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADF35E93D
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 03:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100849; cv=pass; b=luBu23s9RrjCtg1FQaEJdUzE6MhuAnK02tItq+sMj7ljCqfrJoY0WDhoEuj+xuds9KJ3KlG75nS3a02UtXM9dpsD9WynWsViEvm0RSHvvEzqneS+rMCqVKYwUGVhtqrKxqHB2aPutCqhju0Bsd6l0MkcYIm5MknT+AR9X9YXkIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100849; c=relaxed/simple;
	bh=UhjLtvzDpou06cQXwARfEzgAAWqhUpj/dJrjnc9MOWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k55D7uQ0l+YBk9hnSMO018AJLAevTIZlWk+3Pr/n0VQWB6DEPSyZSiJ+XZ2lI4cZU2MvSH1N1llQd+LhepdPVH/pzWq34meVgcBK9Smje7FepnL8H/NC2pRtgFwA/OMmeSp4EFZNP9JsLhdbW2mFw4kbqz5c+1iv/g/u/pEF0Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnQz9Jcr; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso166260a91.0
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 20:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775100845; cv=none;
        d=google.com; s=arc-20240605;
        b=ZtP5eVvLbnvk6nvqFQsPzz5bCGIw7zADyH3A93ZTo3FJ0as/oymqUSyH91zUi7foOM
         aX94ts+NRCNj2BS5zHHiINd8inWXrKS1gEMyE7gwLMdmF0GY6FU3VUqLFpp4TXWsA+Hp
         OraPHPMmlf+hpfSslBfUkYcHi5erRKYXxvp+1p2NaZFaS7B/RUKDcxxHQFV6CvsHCwuB
         JY6EjTElWjSYBu2Ppv1JW8VJaZ1mTkiMNAjcBBJOUkTANNAQiJh4uP1h3N+iLi8S8l9v
         1PZgnELPMF1d0OuMxE5ymkKsi7UU7AQgBMjyYj74Zme773WPUczngN2XcqHYuX6s6mif
         qkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/J2uF2/Ma2hV+2GrDKzcXv6J/tpkVJTVgjFT4h2TI+k=;
        fh=O0yLEtoWC7tVMn7z3rMQSGzdcjqB67kjJ9HSBrIiGL8=;
        b=dfolU5C3rCj85TwggAh6GhZzviL4LXXyDgqb3a9+VbpF4kjtK3Xl6Oh9+6SJSveStg
         VYpOlqIBzuLWw4KHMlm9tOrsMGr7ox+QWQxTDetpPxnV8vM4rAVnlOrJBO73tvQnI8Cz
         yfzFW+5Sj31H0jC9reYWy0RtZF41IlSOn/XObmLK1eKAsz4sIb/7E3Tg0wzffZzLFrPi
         xtB4MMnWdtstghVXJuxsjtHI6oF6+Au8hdrA9VDwzjc3XNyR41u6fGZ2SfHXq3BXD70q
         z366tw2yn/zDyEmC9M5WTFNytdy3gCAADFY170FBBRpsnpd5rZPNBoUcEuyjVtLgO3Df
         ieow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775100845; x=1775705645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J2uF2/Ma2hV+2GrDKzcXv6J/tpkVJTVgjFT4h2TI+k=;
        b=BnQz9JcryuNw6eDgWOOJC0XL26CO3aBYfb4DYSaBB6G2GMXSQai1oQQNUmFut2CY7m
         go8L2ot1CKAoFeQP5Zq/uzxlJBznXyUNjOtL+7WgNMELqIcKnH+h0oPtWISnAXJYlA5L
         3wH4fonB/IOK/TmeuChqrxyOyQxpfJ0A5HyPN0cLP3N0Jyqk/xCn+nClqIe31wS5JDWK
         qn4Yf3WARU7rAPY0u5Uand9UKB9oO74VyRzT8/hhZr+kWUpAuNOPtdNvurfsgPqiDXeU
         pE74KHmPq0YWTDH/6HBjqw176R9sCMYs4PSqNlDYbaUlox/MX4mut+zGu1M0InHy6a1l
         jB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775100845; x=1775705645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/J2uF2/Ma2hV+2GrDKzcXv6J/tpkVJTVgjFT4h2TI+k=;
        b=EjNB6JCojNF+5n0kegC2H1fs8iRRd5GGPVz8n2EmxgBssRdS/qmUCwo4dnutQVSn6e
         8zwhHIKAVBBCOjx0K35173nCzmuRRPRXyqA1WtyGHjIkjAsZflF6iur5M3I8E1ur1iCR
         OFMct/EUniroXJZ1RTQDfByiCWkw1J4dgHUSUJGrcZ7enB2TEs8GbJi53sEZ+luANnOs
         bka3+e1nIIdkl88bw7p79FwTiiZvz5/VRKoFGnm3tfsVNTXF3hltRd/PhQ+08Cq03dAh
         7Jfkj2D7KxeJjXWSDJXfjY+WGsjKq9kFDzyD0GY/7rEHSqRflxyK9vEEXdjk5YARVQNr
         qbzA==
X-Forwarded-Encrypted: i=1; AJvYcCVdmd3B6OkF7JzSd1l2yi31dIZwSlmJykK6YO6Vdph2lT1kl3NHsA845JJZ9alPQR1lJYh5T+mok6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hhqUeWkKBVG2P/Ik6TKxTSRbFfk0l+8xg9eI+H1TXcQ69bpE
	Hk2ZnXEKKJ6ljzWpPofiEn4SLoOYTwmGUXvrISwH+X5IHNWGPwz2Hh0D3A3+gKfJVCehiNQww4f
	3ZLf2FBcJeUqIYEGk/A31/kjK/tV6yqE=
X-Gm-Gg: ATEYQzwcVdfcg24wdrtBMhW6r4eWkoNpvEAG6nNYU27f5KdGiWzBHZ5kXPOenI+dOHP
	ZjvdrfSISEUp+5oP8vBW+m3+AeKum2JZS3EPx4TYTfvvnvY7RBD7x8kdF2+pBBTLtWAKavcZUOW
	BLme438aO0N8ItRNADa1/A+6pP+ocXAkKOgJDwGHr27S9wvLtjbnjy5a9A7eqGj2DuIE6D7klCo
	MZnb/aOblhxr4v/dhISx7vCn2ATsCXdS7B5n4x5jfw/YfPQw9ej0o0r+6uo84qiKaTebdtCJCO1
	O5Hx6dk=
X-Received: by 2002:a17:903:32cc:b0:2b0:5990:cf1e with SMTP id
 d9443c01a7336-2b269c80fd2mr58675965ad.33.1775100844939; Wed, 01 Apr 2026
 20:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de> <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 2 Apr 2026 11:33:52 +0800
X-Gm-Features: AQROBzCSdKcZaLbfDao98j_I1toGLvfE9bJe_Lqq7ufOyEXTyqcaETde8D_cryk
Message-ID: <CAA+D8APVK8SUSK7_mQ0Rr5EYSSkxaWG52KYRKN=XpBV-dZTskg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for i.MX8M
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9821-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,mentor.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shengjiuwang@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3571F38339B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Sep 12, 2025 at 6:05=E2=80=AFAM Marco Felsch <m.felsch@pengutronix.=
de> wrote:
>
> Starting with i.MX8M* devices there are multiple spba-busses so we can't
> just search the whole DT for the first spba-bus match and take it.
> Instead we need to check for each device to which bus it belongs and
> setup the spba_{start,end}_addr accordingly per sdma_channel.
>
> While on it, don't ignore errors from of_address_to_resource() if they
> are valid.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 58 ++++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3ecb917214b1268b148a29df697b780bc462afa4..56daaeb7df03986850c9c7427=
3d0816700581dc0 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -429,6 +429,8 @@ struct sdma_desc {
>   * @event_mask:                event mask used in p_2_p script
>   * @watermark_level:   value for gReg[7], some script will extend it fro=
m
>   *                     basic watermark such as p_2_p
> + * @spba_start_addr:   SDMA controller SPBA bus start address
> + * @spba_end_addr:     SDMA controller SPBA bus end address
>   * @shp_addr:          value for gReg[6]
>   * @per_addr:          value for gReg[2]
>   * @status:            status of dma channel
> @@ -461,6 +463,8 @@ struct sdma_channel {
>         dma_addr_t                      per_address, per_address2;
>         unsigned long                   event_mask[2];
>         unsigned long                   watermark_level;
> +       u32                             spba_start_addr;
> +       u32                             spba_end_addr;
>         u32                             shp_addr, per_addr;
>         enum dma_status                 status;
>         struct imx_dma_data             data;
> @@ -534,8 +538,6 @@ struct sdma_engine {
>         u32                             script_number;
>         struct sdma_script_start_addrs  *script_addrs;
>         const struct sdma_driver_data   *drvdata;
> -       u32                             spba_start_addr;
> -       u32                             spba_end_addr;
>         unsigned int                    irq;
>         dma_addr_t                      bd0_phys;
>         struct sdma_buffer_descriptor   *bd0;
> @@ -1236,8 +1238,6 @@ static void sdma_channel_synchronize(struct dma_cha=
n *chan)
>
>  static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>  {
> -       struct sdma_engine *sdma =3D sdmac->sdma;
> -
>         int lwml =3D sdmac->watermark_level & SDMA_WATERMARK_LEVEL_LWML;
>         int hwml =3D (sdmac->watermark_level & SDMA_WATERMARK_LEVEL_HWML)=
 >> 16;
>
> @@ -1263,12 +1263,12 @@ static void sdma_set_watermarklevel_for_p2p(struc=
t sdma_channel *sdmac)
>                 swap(sdmac->event_mask[0], sdmac->event_mask[1]);
>         }
>
> -       if (sdmac->per_address2 >=3D sdma->spba_start_addr &&
> -                       sdmac->per_address2 <=3D sdma->spba_end_addr)
> +       if (sdmac->per_address2 >=3D sdmac->spba_start_addr &&
> +                       sdmac->per_address2 <=3D sdmac->spba_end_addr)
>                 sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_SP;
>
> -       if (sdmac->per_address >=3D sdma->spba_start_addr &&
> -                       sdmac->per_address <=3D sdma->spba_end_addr)
> +       if (sdmac->per_address >=3D sdmac->spba_start_addr &&
> +                       sdmac->per_address <=3D sdmac->spba_end_addr)
>                 sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_DP;
>
>         sdmac->watermark_level |=3D SDMA_WATERMARK_LEVEL_CONT;
> @@ -1447,6 +1447,31 @@ static void sdma_desc_free(struct virt_dma_desc *v=
d)
>         kfree(desc);
>  }
>
> +static int sdma_config_spba_slave(struct dma_chan *chan)
> +{
> +       struct sdma_channel *sdmac =3D to_sdma_chan(chan);
> +       struct device_node *spba_bus;
> +       struct resource spba_res;
> +       int ret;
> +
> +       spba_bus =3D of_get_parent(chan->slave->of_node);

if the chan is requested by __dma_request_channel(),  the chan->slave =3D N=
ULL
Then there will be an issue here.

Best regards
Shengjiu Wang

> +       /* Device doesn't belong to the spba-bus */
> +       if (!of_device_is_compatible(spba_bus, "fsl,spba-bus"))
> +               return 0;
> +
> +       ret =3D of_address_to_resource(spba_bus, 0, &spba_res);
> +       of_node_put(spba_bus);
> +       if (ret) {
> +               dev_err(sdmac->sdma->dev, "Failed to get spba-bus resourc=
es\n");
> +               return -EINVAL;
> +       }
> +
> +       sdmac->spba_start_addr =3D spba_res.start;
> +       sdmac->spba_end_addr =3D spba_res.end;
> +
> +       return 0;
> +}
> +
>  static int sdma_alloc_chan_resources(struct dma_chan *chan)
>  {
>         struct sdma_channel *sdmac =3D to_sdma_chan(chan);
> @@ -1527,6 +1552,8 @@ static void sdma_free_chan_resources(struct dma_cha=
n *chan)
>
>         sdmac->event_id0 =3D 0;
>         sdmac->event_id1 =3D 0;
> +       sdmac->spba_start_addr =3D 0;
> +       sdmac->spba_end_addr =3D 0;
>
>         sdma_set_channel_priority(sdmac, 0);
>
> @@ -1837,6 +1864,7 @@ static int sdma_config(struct dma_chan *chan,
>  {
>         struct sdma_channel *sdmac =3D to_sdma_chan(chan);
>         struct sdma_engine *sdma =3D sdmac->sdma;
> +       int ret;
>
>         memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg=
));
>
> @@ -1867,6 +1895,10 @@ static int sdma_config(struct dma_chan *chan,
>                 sdma_event_enable(sdmac, sdmac->event_id1);
>         }
>
> +       ret =3D sdma_config_spba_slave(chan);
> +       if (ret)
> +               return ret;
> +
>         return 0;
>  }
>
> @@ -2235,11 +2267,9 @@ static struct dma_chan *sdma_xlate(struct of_phand=
le_args *dma_spec,
>  static int sdma_probe(struct platform_device *pdev)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
> -       struct device_node *spba_bus;
>         const char *fw_name;
>         int ret;
>         int irq;
> -       struct resource spba_res;
>         int i;
>         struct sdma_engine *sdma;
>         s32 *saddr_arr;
> @@ -2375,14 +2405,6 @@ static int sdma_probe(struct platform_device *pdev=
)
>                         dev_err(&pdev->dev, "failed to register controlle=
r\n");
>                         goto err_register;
>                 }
> -
> -               spba_bus =3D of_find_compatible_node(NULL, NULL, "fsl,spb=
a-bus");
> -               ret =3D of_address_to_resource(spba_bus, 0, &spba_res);
> -               if (!ret) {
> -                       sdma->spba_start_addr =3D spba_res.start;
> -                       sdma->spba_end_addr =3D spba_res.end;
> -               }
> -               of_node_put(spba_bus);
>         }
>
>         /*
>
> --
> 2.47.3
>
>


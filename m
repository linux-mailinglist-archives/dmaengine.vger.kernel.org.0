Return-Path: <dmaengine+bounces-3623-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B349B2995
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529D8B214C2
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C31917D8;
	Mon, 28 Oct 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpwY5iVl"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A10190472;
	Mon, 28 Oct 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101481; cv=none; b=gNaO19j/sjt4CNheKYO8At5V5XYzFnvnYTAdO/LPh1hOlaVj8ysQ3PcE30WUQWZuXR8uj1f7q+i+Bxu9L7AmMu1ISDtju2ZhZJcpdmn3foUYupzoUubE8RE0o6INKFY5oAkfpMgpv/I06Yojx1VDdPlmcTpSgaR5HKINnQiD0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101481; c=relaxed/simple;
	bh=sqtEmGyJxUrT/zTyDRuWnbONHCPX8v4B6zv0Gwkn+7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7KgzHPd1xRXzsl42t9ht+Gk84FvclpKk9bKrpe0td8UXDGReLifLFHvyFo/Cb5Fhfetv0Ib9LYJyUR920/Vsfkj4uvksGCnPdWL807XAWuNPC9yFWGJaDBsYEYm+6hM9joBZ2Mkh+bffgNBQY+TH6HFer8PH4X74x3JFuJvPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpwY5iVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B85C4AF09;
	Mon, 28 Oct 2024 07:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730101481;
	bh=sqtEmGyJxUrT/zTyDRuWnbONHCPX8v4B6zv0Gwkn+7k=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=fpwY5iVlNZtt6cifQeQIfQZJ3OQBajKtiORcnnSCyAv4J44FKYhLIW3AWerJNDmZZ
	 ixBfPie5e/3CfHGnUXx/1UVWtEhDMl+ctYDfauNjwGhyQijTAnFcxHZOWITdIADP8W
	 p38kvDSQ7sYcU3TwC9MdIp0WvLbfP0aNHrMxLS+I0l1WzAzBz/v7F3vMF5rMaFaKe9
	 TiQu6orbq/522/kFY+Is0gdoGn4hxmjXiPJJiJ5ZHhxshOWJfdTwDlOEUTk8RZyyXl
	 QReH162f2xmbHy40QWroiZCTBu+nqWs1GWZhw2CXC1KEegkYE5APTLWiWXqvXMWkW/
	 /tO+YC/QZdfmA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb58980711so34302241fa.0;
        Mon, 28 Oct 2024 00:44:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0DI8QdkMblPMl9GlrIzla08nOqRKQaYgu7Y0unnfh7Hh+d+mCSultrLia1VV5oGftNPJtf98C9FI=@vger.kernel.org, AJvYcCWqDRWdJmWsEDhYZzy6KjRP+578dM6GFkyWjWukR4In+GDkF1oA/LLDQ9SFJDtmqRkG8t3vMBIa3r6JtuSC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7nnHLSvM3bgJf/0m0vdjrIrkKxovQWtEo7VDSXlJwf+ONj9Y
	rSHzYPj6D3sAJbRKKzbcqyovJRckLEuNnckUXOz6Jlcf7/bNsyXP0O1wRy0UuS/2jPylHOf7Xly
	plsTfdkzvSMd21ZRCm3N+/PyG/Mc=
X-Google-Smtp-Source: AGHT+IEtwwtwCu4NZilEk7a5bhHxyxS236QhCQr+S/RpcV6NeWhfrwLpBXXtHddov7on8VB3TcEd5dQmDpKY7fFQcTY=
X-Received: by 2002:a2e:f12:0:b0:2fa:dc24:a346 with SMTP id
 38308e7fff4ca-2fcbdfbab66mr20894921fa.21.1730101479749; Mon, 28 Oct 2024
 00:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
 <20241027091440.1913863-2-csokas.bence@prolan.hu> <nlhsxigg3rbfvua76ekmub4p6df2asps2ihueouuk6zkbn56zl@xdj6jzzt4gfb>
 <b74dafed-197a-4644-a546-54c7a1639484@prolan.hu>
In-Reply-To: <b74dafed-197a-4644-a546-54c7a1639484@prolan.hu>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 28 Oct 2024 15:44:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ZXftjrG9+f1_88=EsU7rM8vnOPZCszWfWYFQ+Do9Xsg@mail.gmail.com>
Message-ID: <CAGb2v65ZXftjrG9+f1_88=EsU7rM8vnOPZCszWfWYFQ+Do9Xsg@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Mesih Kilinc <mesihkilinc@gmail.com>, 
	Vinod Koul <vkoul@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 3:37=E2=80=AFPM Cs=C3=B3k=C3=A1s Bence <csokas.benc=
e@prolan.hu> wrote:
>
> Hi,
>
> On 2024. 10. 27. 21:42, Krzysztof Kozlowski wrote:
> > On Sun, Oct 27, 2024 at 10:14:32AM +0100, Cs=C3=B3k=C3=A1s, Bence wrote=
:
> >> From: Mesih Kilinc <mesihkilinc@gmail.com>
> >>
> >> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
> >> has this bit but in order to support suniv we need to add it. So add
> >> support for reset bit.
> >>
> >>   static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev=
)
> >> @@ -1215,6 +1218,15 @@ static int sun4i_dma_probe(struct platform_devi=
ce *pdev)
> >>              return PTR_ERR(priv->clk);
> >>      }
> >>
> >> +    if (priv->cfg->has_reset) {
> >> +            priv->rst =3D devm_reset_control_get_exclusive(&pdev->dev=
,
> >> +                                                         NULL);
> >> +            if (IS_ERR(priv->rst)) {
> >> +                    dev_err_probe(&pdev->dev, "Failed to get reset co=
ntrol\n");
> >
> > syntax is: return dev_err_probe()
> >
> > Best regards,
> > Krzysztof
>
> Thanks! And regarding v3 of this patch, I have `clk_disable_unprepare()`
> after `dev_err_probe()`, I assume I have to let that be i.e. not return
> immediately?

I suggest adding a patch to switch the clk API calls to devm_clk_get_enable=
d()
which handles all the cleanup. Similarly you can switch to

    devm_reset_control_get_exclusive_deasserted()

for this patch.


ChenYu


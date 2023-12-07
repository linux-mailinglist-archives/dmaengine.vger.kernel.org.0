Return-Path: <dmaengine+bounces-394-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0D808219
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 08:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C30DB20AE3
	for <lists+dmaengine@lfdr.de>; Thu,  7 Dec 2023 07:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456C19BD7;
	Thu,  7 Dec 2023 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5yzTgP0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3188010CE;
	Wed,  6 Dec 2023 23:42:48 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db538b07865so736637276.2;
        Wed, 06 Dec 2023 23:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701934967; x=1702539767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xATSf1mKGxc0Izf+E9mhfmBLrFa4vSy5SZKU8hVo4UI=;
        b=W5yzTgP0N2bsHepRah5qef9B83T2h6grd2YDMNZawM63Ngv4SXkFJCGNcLsJte2x9k
         MqwiDGrkO57/p6IPIVJO9uN3dpDXifIYJluoNYSXi+i48p2lVKnDEGfL7bBFiIyDRuay
         S+xs72Z/bP9IRQP/qdZGAoXxuLAOrbQzX1ZtpmNwfQ3jqu6SPRAsFA/bUbzf35pGQi1r
         Dng3gbkdEbcwjx+v2mZIUlYrMTUE5yQ+77sP5MsZ7/yuEhg6Qj6aiU/w0R05oJgPtaoS
         yMkRRASxt9r/GWCrYYJt2NhmlMGJ1TJXByPLPUQXjkbeIBUbWNxJXoFbCsFaQVCHQl6M
         Z4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701934967; x=1702539767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xATSf1mKGxc0Izf+E9mhfmBLrFa4vSy5SZKU8hVo4UI=;
        b=EGwiGjh7YK5A3FYLyAQfihlrl8z+uSrN2bEcMP5Uuh41w6n0XkkoptjrwpUt2m9Xys
         GYxX5GiGw3XDhLk/PSZI0Yev+8HSIlTXAZBy4hUH7yQImFlxf4X1fPJrBP8QGRQ3QtyD
         Z5TXkkQ7Y/kqKN/yloPpoldxBCFMVL7Y+oljE5JTcihXzNHSB9Ir8tWZtqtjvBMSm6RV
         TxSdw9nmSxBQ7nKSIRgfpFrMwsOzE7kpOFAkQCfgO5m739pJrbE7lqw5D1MZSB6XV2kN
         UwWdwuCT4MASoppEZnB1wUo4zZuUauTseUrZF57N+V6FD+61sdJnLEteJpEm4DiEFUYh
         7qKQ==
X-Gm-Message-State: AOJu0YwYas63chUfzaQ2qY9wpmmcKxrwmNNo3YZv0c3mPx1Lzxl6h/vo
	IImUynLuVQGG84fr9W6ifDd3wnaG3LIKSZtE19I=
X-Google-Smtp-Source: AGHT+IEW0mODy37dFWhUY4yRWuukw0NSZavDDe4/boxu94cJxA4p9htNWyfWPlcrhg//95Max1io8ZK1yfKK130e4J8=
X-Received: by 2002:a25:d60a:0:b0:db7:dacf:ed70 with SMTP id
 n10-20020a25d60a000000b00db7dacfed70mr1970234ybg.81.1701934967186; Wed, 06
 Dec 2023 23:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700644483.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1700644483.git.zhoubinbin@loongson.cn>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 7 Dec 2023 13:42:36 +0600
Message-ID: <CAMpQs4KJpXotjhZO9tt_jQn+4HDkwros-=9hvDcys-Z5LGsmxA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] New driver for the Loongson LS2X APB DMA Controller
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, Xuerui Wang <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, Yingkun Meng <mengyingkun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 3:27=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> This patchset introduces you to the LS2X apbdma controller.
>
> The Loongson LS2X APB DMA controller is available on Loongson-2K chips.
> It is a single-channel, configurable DMA controller IP core based on the
> AXI bus, whose main function is to integrate DMA functionality on a chip
> dedicated to carrying data between memory and peripherals in APB bus
> (e.g. nand).

Hi Vinod:

Gentle ping. Any comments on this series of patches?

Thanks.
Binbin
>
> Thanks.
>
> ----
> V5:
> patch(2/2):
>  - Rebase on dmaengine/next;
>  - Annotate struct ls2x_dma_sg with __counted_by;
>  - .remove()->.remove_new();
>  - Drop duplicate assignments in ls2x_dma_chan_init().
>
> Link to V4:
> https://lore.kernel.org/all/cover.1691647870.git.zhoubinbin@loongson.cn/
>
> V4:
> patch(2/2)
>   - Drop linux/of_device.h;
>   - Meaningful parameter name for ls2x_dma_fill_desc(): i->sg_index;
>   - Check the slave config and reject invalid configurations;
>   - Update data width handle;
>   - Use generic xlate: of_dma_xlate_by_chan_id().
>
> Link to V3:
> https://lore.kernel.org/dmaengine/cover.1689075791.git.zhoubinbin@loongso=
n.cn/
>
> V3:
> patch(1/2)
>   - Add clocks property;
>   - Drop dma-channels property, for we are single-channel dmac.
> patch(2/2)
>   - Add clk support.
>
> Link to V2:
> https://lore.kernel.org/dmaengine/cover.1686192243.git.zhoubinbin@loongso=
n.cn/
>
> V2:
> patch(1/2)
>   - Minor changes from Conor;
>   - Add Reviewed-by tag.
> patch(2/2)
>   - Fix build errors from lkp@intel.com.
>
> Link to V1:
> https://lore.kernel.org/dmaengine/cover.1685448898.git.zhoubinbin@loongso=
n.cn/
>
> Binbin Zhou (2):
>   dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
>   dmaengine: ls2x-apb: new driver for the Loongson LS2X APB DMA
>     controller
>
>  .../bindings/dma/loongson,ls2x-apbdma.yaml    |  62 ++
>  MAINTAINERS                                   |   7 +
>  drivers/dma/Kconfig                           |  14 +
>  drivers/dma/Makefile                          |   1 +
>  drivers/dma/ls2x-apb-dma.c                    | 705 ++++++++++++++++++
>  5 files changed, 789 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-a=
pbdma.yaml
>  create mode 100644 drivers/dma/ls2x-apb-dma.c
>
> --
> 2.39.3
>


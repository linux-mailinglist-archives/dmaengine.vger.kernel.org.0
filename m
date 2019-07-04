Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0045F7A5
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2019 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfGDMGs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jul 2019 08:06:48 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:40137 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbfGDMGr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jul 2019 08:06:47 -0400
Received: by mail-lf1-f51.google.com with SMTP id b17so483998lff.7;
        Thu, 04 Jul 2019 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTkfUI5zLzVNOyUZXexQl1Bggm8zbSH8fyasWshB1Hg=;
        b=MPh7nvTwj2pkyjfgcekBMNLi5oDPufvo1Ho2+aihzyD6MaxNinLmrjUo3M2kO0XR3S
         YG+Dl/t9iCaW3Uwdtt01WcTAN75aUe3GbUUF6k+lAin9/wlw9v9PRoCHj5EbknyRvw2r
         swpIuByfQknbjMSlvzNTZoOFeX0o+nuUC+YmZZbz67gqW/I09oVO6D3v6zbIpSCzbWEq
         v6N9nxlYEJHj1hK7jzJrdumNz/obyDBsiySBdKj1izeG628zh+NlNUH6a9818r06F1nt
         CUbTBQ/iR+1kgwutgGwSsU+RypQ0WQHRbP3eBMFZwz4z7UeqfU0a5eVaKzV79LHuO/fL
         3gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTkfUI5zLzVNOyUZXexQl1Bggm8zbSH8fyasWshB1Hg=;
        b=EW8lLWqasgPCL2fyNnszeV4v26VvirxZDDris3lv5/dgUfjVluZR2Gpm+OSCCpgcPx
         QzMn2yTn5RQboV7aEh4NQjq/JArvWugDIvAIVEiQzsHhdwH3uDP11BKP2+93X1Jv7UHv
         lBIkIjRIe4tW6BpxrhbWoyrw1jUuWNYClIQSDQlLAVpadWbc4vsxaKEtQX/9nJpN5g6U
         HjUQWvdln8jdGYVUNtqh1D5LSGbq/emFu4Fb9CD0xQUdWHMgmlsf4IMKZs1sMDVNJLG6
         T1ymkTpkJw0cF1RE/tnw06Ucaf8vTsK0TyeUP6A54mG/ZD9Yo4voMroSq6sLwu7xAUAX
         AbHA==
X-Gm-Message-State: APjAAAVocJd4B3CJvRBB7I6l+xdTQ/kwzivjDXHhnVvoKHbHEi885gof
        bSQK2diUmNaDk05bOQyYiUNRxIiqygMD4whCeso=
X-Google-Smtp-Source: APXvYqwACPiX5jRVWpvpEJPURWsQZiVp9zq9X2m0pRR6Tqlg5IzXTi4R893w3QYwU/YUlMceWKeiRSflY0C6o5MHQLw=
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr2784221lfo.90.1562242005405;
 Thu, 04 Jul 2019 05:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfx6HeJgTu9TiusGACyt+uXVSmnpibO0m-qzCvFQNGK7g@mail.gmail.com>
 <VI1PR04MB44316904F765E93CC1DFA0EDEDFA0@VI1PR04MB4431.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB44316904F765E93CC1DFA0EDEDFA0@VI1PR04MB4431.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Jul 2019 09:06:35 -0300
Message-ID: <CAOMZO5BFim2tWxH3nKV08Y1C2-rB7kr8_9v=Qgj+6AXa30-ExQ@mail.gmail.com>
Subject: Re: [EXT] [BUG BISECT] Net boot fails on VF50 after "dmaengine:
 fsl-edma: support little endian for edma driver"
To:     Peng Ma <peng.ma@nxp.com>
Cc:     =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peng,

On Wed, Jul 3, 2019 at 11:10 PM Peng Ma <peng.ma@nxp.com> wrote:

> So we need this patch, I make some changes,Please help me to test attatchment on VF50 board,

You need to change the Subject to something like:

Subject: [PATCH] dmaengine: fsl-edma: Add support for LS1028A

Also, in the commit log, please change "Our platforms" to "LS1028A"

Please remove this part: "Current eDMA driver does not support Little endian"

,which is not correct.

Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6FDAC7A
	for <lists+dmaengine@lfdr.de>; Thu, 17 Oct 2019 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406320AbfJQMlh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Oct 2019 08:41:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43023 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfJQMlh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Oct 2019 08:41:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so2366650ljj.10
        for <dmaengine@vger.kernel.org>; Thu, 17 Oct 2019 05:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yfx0Qj1rQn2OmtLvzGD+tupqKl0ANiTAmTmE7GtqB/c=;
        b=EBfaTkVU2EzpHfqbCpcWQDH0yBUBKdmrs4HPvzp4DVmP+SghhcWQYcxFTjednqSfei
         CduVfjtcs7s39ZzeyD020vFCQ898l9ZhCGRVIta1Kf9HQSYf5ahiGOjdk0QtjEsBvSQh
         9gJ4qKHrOoUdJ/PYLxWVhgI3VjuRp1lK3kKGw2rH9yWL5cPnGSDsRIoXdg3e/f7z9SYD
         mGsIEP3c6wTAtTuw3+kNL///vVueLLTzGyL2O8vw/1b1/VILsvxv/WnbqBZoqZ3Zrau6
         1BRcVz05/csqRdz+lzmDhGRLk4xWBBt/xzqxWEQSJw1dnUeKt4XuYsoJSRUVmryuhGfW
         jn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yfx0Qj1rQn2OmtLvzGD+tupqKl0ANiTAmTmE7GtqB/c=;
        b=lac7MUuKUBEPxOp+gLWwiY4Pxg4z0niNSzzZTzB1SCn1WZDezQcafFwddthrow+5BT
         JrBEerjfr0sCQ59KsITf6JJKx3fcqjrS7ZHR15GtxVPYYp0XSKaNBYbaJGEt5gwJOy3x
         BjjtpHIitLPAYewNk/FECK+w0r7sTdWcO+PvW9e5KfQtCsa1xnDZldrw599M5PuUzLlw
         V0qQ64W9D2G9JMk7YMVWRFhu6ZXZ2roQ9YHKGn93bUW4dfqMf3N76fo6XHbqyz4BSKT2
         xrMk5hzjinO4jfZaaJG8Tbzgl9ZN0UroNTrs7zOm+2esNsPWZctlVOqoQvIa+hwbU8GC
         sM0g==
X-Gm-Message-State: APjAAAX2gH+dO5tKT6uJPYL8Juz3U+3d3TNeR+HdoeIwme3Q8Z2uaEAF
        YTkaUUsRKpWbaIvhRaSHEy5yl+K262dSsYOO0T4=
X-Google-Smtp-Source: APXvYqwGMVFYiAIJMausUX0KhxA+9h/75g6z2SFKHL+BGId19M7UCqJE6ESTtzc0A4OLCQYPDr5LqTuCiP1tF7kn0nw=
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr2388800ljj.239.1571316093934;
 Thu, 17 Oct 2019 05:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAH+2xPB7rbeJnOPU10Ss9BhV_2DJV-ToQ3XNOy97+vrGx+ubcg@mail.gmail.com>
 <20191014141344.uwnzy3j3kxngzv7a@pengutronix.de>
In-Reply-To: <20191014141344.uwnzy3j3kxngzv7a@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Oct 2019 09:41:24 -0300
Message-ID: <CAOMZO5CkxnW_6gj9QoUD9Hj6m-R7LD93ip66+s6x+1CkcXoOjg@mail.gmail.com>
Subject: Re: Regression: dmaengine: imx28 with emmc
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>, bth@kamstrup.com,
        Vinod <vkoul@kernel.org>, linux-mtd@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Sascha,

On Mon, Oct 14, 2019 at 11:14 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From 3f7a1097099c9e57e31a86503edc479f9964bc95 Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 14 Oct 2019 16:07:31 +0200
> Subject: [PATCH] mmc: mxs: fix flags passed to dmaengine_prep_slave_sg
>
> Since ceeeb99cd821 we no longer abuse the DMA_CTRL_ACK flag for custom
> driver use and introduced the MXS_DMA_CTRL_WAIT4END instead. We have not
> changed all users to this flag though. This patch fixes it for the
> mxs-mmc driver.
>
> Fixes: ceeeb99cd821 ("dmaengine: mxs: rename custom flag")

Please add:

Cc: stable@vger.kernel.org

so that it can be backported to 5.3.x

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

This fixes the rootfs mounting issue from SD card on a imx28-evk running 5.3.6:

Tested-by: Fabio Estevam <festevam@gmail.com>

Thanks!

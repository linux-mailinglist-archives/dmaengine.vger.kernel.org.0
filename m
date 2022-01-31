Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D04A3DC4
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 07:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357730AbiAaGmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 01:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357750AbiAaGmO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 01:42:14 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4975BC061714;
        Sun, 30 Jan 2022 22:42:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x7so24724359lfu.8;
        Sun, 30 Jan 2022 22:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+o572UxaIbZHoDwhLTVrM3EDgH23zaHCOLnwSbXuzU=;
        b=cTZx/yZ4fzFYtW0jjpGIXvjPBY2DEd7BUk26OwFtkSDtbLWfc2407PPv61PAVjRrId
         p1qXOgSsyA4fcOqDOdppDzF/gC+2MF5ZbXbu8nLDsox5tG+TXW+os0N8wVH296TBoFSQ
         2psGB3rcnl7VjjM7kF6WRNaz6P+g6fLSxXGhCvFwAcKBBNuN2jdUNJce+GJFzvwzty9I
         dYJ7QDMz9wpu2nFopt/N4ewIv2N51Vg0LKjdxmSeZ5MbBTFi/T3xxSjvOstHrPJzNIqH
         W38yBtdXR/c5jhhrP+peRj8Org3wFG5MWJvHFTEN5JkhHPVCFidqXSFtBslaAsKVsG1M
         LC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+o572UxaIbZHoDwhLTVrM3EDgH23zaHCOLnwSbXuzU=;
        b=vZ5vIjRKo65uC1hnT6iliJnsggXC1VacCJV1nIotZF8Wa97DteL+CkiGfZpv5JgWr1
         nAkB45RMs4x2YlqeQz/oaKrsUcbUSsqK0uMf/kBHMbns6n3D1YcMaP6xKpKX90MMgmN3
         20KDe8Eu294IfkSxJZIyYj3CosRcU8gLLO7gUjKSDAv0U1aQA3G1zTbtfHH7I8UyiVWP
         pR8y7Vc04v6M4ya8d8jRsIY0PDfCcCzNwnHBo9oBW5ivHGEUvJEDPShRlsNawkAkk2nE
         bVbKvXabfAEjfUZcuqWdOzlpeuufLevwfw4/8H4qNdy+I9x3KOGGClNf6+NDg0FfGcxV
         WXbg==
X-Gm-Message-State: AOAM533GTwbMNpZlwWZCuDws0rfMq+e9nEuj4dPEHw9QhlMrlumpslbM
        aJlGIXEKRL0+wG7FKhxpZ9k=
X-Google-Smtp-Source: ABdhPJzWAQG3MWrvtdu5/E2ofP4JhzRGTBEMJSKMAJIiXAlDNxAndgTj75Qw6bfkzdHQUp6ZLhMsvQ==
X-Received: by 2002:a05:6512:358d:: with SMTP id m13mr14231708lfr.559.1643611332523;
        Sun, 30 Jan 2022 22:42:12 -0800 (PST)
Received: from dimatab (109-252-138-126.dynamic.spd-mgts.ru. [109.252.138.126])
        by smtp.gmail.com with ESMTPSA id w17sm2021531lfa.33.2022.01.30.22.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 22:42:12 -0800 (PST)
Date:   Mon, 31 Jan 2022 09:42:05 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <20220131094205.73f5f8c3@dimatab>
In-Reply-To: <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
        <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
        <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
        <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
        <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
        <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

=D0=92 Mon, 31 Jan 2022 04:25:14 +0000
Akhil R <akhilrajeev@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > 30.01.2022 19:34, Akhil R =D0=BF=D0=B8=D1=88=D0=B5=D1=82: =20
> > >> 29.01.2022 19:40, Akhil R =D0=BF=D0=B8=D1=88=D0=B5=D1=82: =20
> > >>> +static int tegra_dma_device_pause(struct dma_chan *dc) {
> > >>> +     struct tegra_dma_channel *tdc =3D to_tegra_dma_chan(dc);
> > >>> +     unsigned long wcount, flags;
> > >>> +     int ret =3D 0;
> > >>> +
> > >>> +     if (!tdc->tdma->chip_data->hw_support_pause)
> > >>> +             return 0; =20
> > >>
> > >> It's wrong to return zero if pause unsupported, please see what
> > >> dmaengine_pause() returns.
> > >> =20
> > >>> +
> > >>> +     spin_lock_irqsave(&tdc->vc.lock, flags);
> > >>> +     if (!tdc->dma_desc)
> > >>> +             goto out;
> > >>> +
> > >>> +     ret =3D tegra_dma_pause(tdc);
> > >>> +     if (ret) {
> > >>> +             dev_err(tdc2dev(tdc), "DMA pause timed out\n");
> > >>> +             goto out;
> > >>> +     }
> > >>> +
> > >>> +     wcount =3D tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
> > >>> +     tdc->dma_desc->bytes_xfer +=3D
> > >>> +                     tdc->dma_desc->bytes_req - (wcount * 4); =20
> > >>
> > >> Why transfer is accumulated?
> > >>
> > >> Why do you need to update xfer size at all on pause? =20
> > >
> > > I will verify the calculation. This looks correct only for single
> > > sg transaction.
> > >
> > > Updating xfer_size is added to support drivers which pause the
> > > transaction and read the status before terminating.
> > > Eg. =20
> >=20
> > Why you couldn't update the status in tegra_dma_terminate_all()? =20
> Is it useful to update the status in terminate_all()? I assume the
> descriptor Is freed in vchan_dma_desc_free_list() or am I getting it
> wrong?

Yes, it's not useful. Then you only need to fix the tx_status() and
don't touch dma_desc on pause.

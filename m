Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEFD34F2DE
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 23:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhC3VNJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhC3VMn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Mar 2021 17:12:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF96DC061574;
        Tue, 30 Mar 2021 14:12:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so13032990qtc.1;
        Tue, 30 Mar 2021 14:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rvg5KeeLafDks20d9MA0DVK+cDxKZn2jW/3PZAzDQ/c=;
        b=k33NE2CXIobJjoB4dL34gEB0xWjLB3X1YdTxpiNE4m0w39+avHYjIPTlPYWXgE++hd
         CGQkltFiOHlY66qiAVKRvXxWVeakz1vHzUgjMGABg2PdcXzfe4r3i+hllFqwhr/VX80V
         uTac3mVQxYNW6lBVUmFdY/ZTI21BQcj9z97C+l86gNTTNqfOUpNO1cef3VITKGOdj5ZS
         ptEdf7sJdINv/ay1cfflAq7AeGQma+759sqdmJKNeuL+0T3qU0k3TxjPWmmAuFuQt/qP
         SnTM8sTfRkspWWUd4gwPfQngwZ66vFuqI7L5F8zrbvx6YUTXzNQsV6Apc9bQGppT2onR
         AZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rvg5KeeLafDks20d9MA0DVK+cDxKZn2jW/3PZAzDQ/c=;
        b=fTh7l8AnHpmyn5B8p4lI4zPD4leGHd59NpdAcFYHwtc1H+GLYkxjLQA1LH9T+llh3e
         GEjP/yWvxo+QV2QIf6Gfps6EvUxfojPmiHuFkJVrHJzsqVpw+nY2efV7gL1sWZZx21zQ
         ZdDYBFNLaB/4r3htkxa2SEk5afhMPBvK1SPRV8GxSoMLRDXbuk2K5e2Rh2jQjZJUBDzF
         cZPM3gtSqO9a8SoIEt4Itog18WEB7nq9rjzSF0fT0RaxllfbEus3W5KCOmOjYGs0y+AP
         70soHtypLCAg1hOyQmIAQ5tN2UTo9NDByNRnZpNw4LuouTqieKlNMZpnLwklbTKDjTbp
         HE2Q==
X-Gm-Message-State: AOAM530d9Asu4tpGmeoRu20aZ8hBr3pEUoYoehamLjm8uc09l9h1Pi5R
        xDI4Tz9785L120qf77D7kbmqBe4BXPKXrg==
X-Google-Smtp-Source: ABdhPJzBICbv2tB+pZHOQUhX9mgUx+2f/OIMBmWy7u6Wt0v1ME2jB1BtLU0fWk8lwylmTW63ROdomw==
X-Received: by 2002:a05:622a:454:: with SMTP id o20mr28861530qtx.292.1617138762074;
        Tue, 30 Mar 2021 14:12:42 -0700 (PDT)
Received: from Gentoo ([143.244.44.215])
        by smtp.gmail.com with ESMTPSA id b2sm119921qtb.54.2021.03.30.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:12:41 -0700 (PDT)
Date:   Wed, 31 Mar 2021 02:42:21 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/30] Revert "s3c24xx-dma.c: Fix a typo"
Message-ID: <YGOUNbCJOHLmeHm9@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        dri-devel@lists.freedesktop.org, hch@lst.de,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <1d989f71fbebd15de633c187d88cb3be3a0f2723.1616971780.git.unixbhaskar@gmail.com>
 <YGNgFuLWc91aGoQj@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yapxdGUX50HbkJ4L"
Content-Disposition: inline
In-Reply-To: <YGNgFuLWc91aGoQj@vkoul-mobl.Dlink>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--yapxdGUX50HbkJ4L
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 22:59 Tue 30 Mar 2021, Vinod Koul wrote:
>On 29-03-21, 05:23, Bhaskar Chowdhury wrote:
>> s/transferred/transfered/
>>
>> This reverts commit a2ddb8aea8106bd5552f8516ad7a8a26b9282a8f.
>
>This is not upstream, why not squash in. Also would make sense to write
>sensible changelog and not phrases and use the right subsystem
>conventions!
>
Changes like this don't deserve a history to tell, specific to changelog, one
line is suffice.

>Droped the series now
>
This is a bad commit slip in , not suppose to be there, thanks for catching
it.

Sorry for the noise.
>
>--
>~Vinod

--yapxdGUX50HbkJ4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBjlDIACgkQsjqdtxFL
KRXbEQf9HOVQ3RETxBGqN9aTy39IsbyS5nu7/kFDhcZEJysEreLDXKPWNNQ2PX5w
cirIvKOlvWXDyrO8kTzZj7lyhdV4i20kBx+wWdBZ5Pzgxv7EsC29/u3MLwHH9eWk
/yvTPpfI8KLYpPNMU8bMS8NKR+hP+75gM0gGO4zmirTubaAIH9709n3MVg4A7Qlj
ZdJE1MCUqt+VHUnBqZzu2Afv10gBlrsy671OsH0K/m8/ZOWoIKg50Epc7s2/LPEg
DnYTel5gyXWtZh4thSXcjV0hm5Q6jzE0DQjGE7NDxeI8yIz4c6hZBJ2OOTXp1h2A
O5yOuKgqXzo95RFK6W9QSbfhv3erIA==
=mURO
-----END PGP SIGNATURE-----

--yapxdGUX50HbkJ4L--

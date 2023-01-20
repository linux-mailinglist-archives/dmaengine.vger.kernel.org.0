Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145AE6752C6
	for <lists+dmaengine@lfdr.de>; Fri, 20 Jan 2023 11:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjATKu2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 05:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjATKu2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 05:50:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6C6B775;
        Fri, 20 Jan 2023 02:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674211827; x=1705747827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HVxjOlrNxTX4w4hEmxDKY12/recHY5kWHUzbvS7si4c=;
  b=wfMMvOzJXucKqcH0vviLsZE6ylZZfsydaHfu1zT8Gg2bixdw6jTWBwKo
   t+zEfxqi63UakcvR1dtgn8FLHkvFBp0+U2jqIcw2VZBiriIsx4SnGzPZH
   kFG+eqz4bglDa8zUiRJUP1R5ER7XkYDz/2ugRZfK5tGQcsGrumjZnmPO5
   UuJe5AOdxu440HV5JVI+9cTChgrh4uFhHe+8AhQ/w+uhReB920QzX+S2U
   Slsk7RaEI6/FimLgQhlWh3Jj/ZOzZfGVHDKo6lJjKH8EBLWGPBxORH6rI
   sKXKJoVYV4t6zHI7rZWnwHjtLwi8eAC90ODhSHjIfWkHmlt1FxOR/kIGW
   A==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="asc'?scan'208";a="196679949"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 03:50:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 03:50:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 03:50:24 -0700
Date:   Fri, 20 Jan 2023 10:50:01 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     shravan kumar <shravan.chippa@microchip.com>
CC:     <green.wan@sifive.com>, <vkoul@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: sf-pdma: pdma_desc memory leak fix
Message-ID: <Y8px2Qky3GZ5wazl@wendy>
References: <20230120100623.3530634-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OF1t+SvYHzumvf3V"
Content-Disposition: inline
In-Reply-To: <20230120100623.3530634-1-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

--OF1t+SvYHzumvf3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Shravan,

On Fri, Jan 20, 2023 at 03:36:23PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
>=20
> Commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a
> DMA channel") changed sf_pdma_prep_dma_memcpy() to unconditionally
> allocate a new sf_pdma_desc each time it is called.
>=20
> The driver previously recycled descs, by checking the in_use flag, only
> allocating additional descs if the existing one was in use. This logic
> was removed in commit b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread
> support for a DMA channel"), but sf_pdma_free_desc() was not changed to
> handle the new behaviour.
>=20
> As a result, each time sf_pdma_prep_dma_memcpy() is called, the previous
> descriptor is leaked, over time leading to memory starvation:
>=20
>   unreferenced object 0xffffffe008447300 (size 192):
>   comm "irq/39-mchp_dsc", pid 343, jiffies 4294906910 (age 981.200s)
>   hex dump (first 32 bytes):
>     00 00 00 ff 00 00 00 00 b8 c1 00 00 00 00 00 00  ................
>     00 00 70 08 10 00 00 00 00 00 00 c0 00 00 00 00  ..p.............
>   backtrace:
>     [<00000000064a04f4>] kmemleak_alloc+0x1e/0x28
>     [<00000000018927a7>] kmem_cache_alloc+0x11e/0x178
>     [<000000002aea8d16>] sf_pdma_prep_dma_memcpy+0x40/0x112
>=20
> Add the missing kfree() to sf_pdma_free_desc(), and remove the redundant
> in_use flag.
>=20
> Fixes: b2cc5c465c2c ("dmaengine: sf-pdma: Add multithread support for a D=
MA channel")
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--OF1t+SvYHzumvf3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8pxygAKCRB4tDGHoIJi
0qXaAQDZziGG9P3c05/6Z1kseB+iYCmBwoVXkIs3fvUu4pMVbAEAuy3QU4BuPBtT
yRzTBRue4wpLPBr8+CnJMHfbDl0n4wM=
=S7BN
-----END PGP SIGNATURE-----

--OF1t+SvYHzumvf3V--

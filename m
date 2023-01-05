Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03665E33A
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jan 2023 04:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjAEDIA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Jan 2023 22:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjAEDH7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Jan 2023 22:07:59 -0500
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 19:07:11 PST
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D7B479EC
        for <dmaengine@vger.kernel.org>; Wed,  4 Jan 2023 19:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1672888030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WpwTbSW3cWcKZM5U8kXueVOv/z4xAg3A+0On/fk10to=;
        b=MAEASK/q5UAIvDG/kDSfG7O1IA/ds3TyDXjGkzmLP/aVaKe0xeqLkKih3/u3BsVGlVskVH
        EktB5DPbQRlwQaJTBVA4/QaMDKWdE5ZskcHJuS0bFc4So5MSSYgua30OnAfpbDPrkKmK/h
        qQI5h3P3lVvwqqWUoXfiz0UukWAPpb5nGU0GSsH7r4xjOF6eG1Ak8c3P4thjB5nUtvh69p
        bXbLdetdtwPoTik6CnhiFMRCZXjmdOUfztBRIT7DeJNhDUxoaM+7S824dVgnqxJFnfwrCO
        oWftggD0DNpSXzZz+e1nl0oKL9MXNjInWLesCSl62Mdjz/S3hldOKjLyYVBH4g==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-316-rdnOjtGaOnSaGl4RhP0QXQ-1; Wed, 04 Jan 2023 22:05:58 -0500
X-MC-Unique: rdnOjtGaOnSaGl4RhP0QXQ-1
Received: from sgsxdev002.isng.phoenix.local (10.226.81.112) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 4 Jan 2023 19:05:54 -0800
From:   Peter Harliman Liem <pliem@maxlinear.com>
To:     <vkoul@kernel.org>, <mallikarjunax.reddy@linux.intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-lgm-soc@maxlinear.com>,
        "Peter Harliman Liem" <pliem@maxlinear.com>
Subject: [PATCH] dmaengine: lgm: Move DT parsing after initialization
Date:   Thu, 5 Jan 2023 11:05:51 +0800
Message-ID: <afef6fc1ed20098b684e0d53737d69faf63c125f.1672887183.git.pliem@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ldma_cfg_init() will parse DT to retrieve certain configs.
However, that is called before ldma_dma_init_vXX(), which
will make some initialization to channel configs. It will
thus incorrectly overwrite certain configs that are declared
in DT.

To fix that, we move DT parsing after initialization.
Function name is renamed to better represent what it does.

Fixes: 32d31c79a1a4 ("dmaengine: Add Intel LGM SoC DMA support.")
Signed-off-by: Peter Harliman Liem <pliem@maxlinear.com>
---
 drivers/dma/lgm/lgm-dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
index 9b9184f964be..1709d159af7e 100644
--- a/drivers/dma/lgm/lgm-dma.c
+++ b/drivers/dma/lgm/lgm-dma.c
@@ -914,7 +914,7 @@ static void ldma_dev_init(struct ldma_dev *d)
 =09}
 }
=20
-static int ldma_cfg_init(struct ldma_dev *d)
+static int ldma_parse_dt(struct ldma_dev *d)
 {
 =09struct fwnode_handle *fwnode =3D dev_fwnode(d->dev);
 =09struct ldma_port *p;
@@ -1661,10 +1661,6 @@ static int intel_ldma_probe(struct platform_device *=
pdev)
 =09=09p->ldev =3D d;
 =09}
=20
-=09ret =3D ldma_cfg_init(d);
-=09if (ret)
-=09=09return ret;
-
 =09dma_dev->dev =3D &pdev->dev;
=20
 =09ch_mask =3D (unsigned long)d->channels_mask;
@@ -1675,6 +1671,10 @@ static int intel_ldma_probe(struct platform_device *=
pdev)
 =09=09=09ldma_dma_init_v3X(j, d);
 =09}
=20
+=09ret =3D ldma_parse_dt(d);
+=09if (ret)
+=09=09return ret;
+
 =09dma_dev->device_alloc_chan_resources =3D ldma_alloc_chan_resources;
 =09dma_dev->device_free_chan_resources =3D ldma_free_chan_resources;
 =09dma_dev->device_terminate_all =3D ldma_terminate_all;
--=20
2.17.1


Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFA81A1C5F
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2020 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgDHHMG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Apr 2020 03:12:06 -0400
Received: from smaract.com ([82.165.73.54]:60432 "EHLO smaract.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbgDHHMG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Apr 2020 03:12:06 -0400
Received: from mx1.smaract.de (staticdsl-213-168-205-127.ewe-ip-backbone.de [213.168.205.127])
        by smaract.com (Postfix) with ESMTPSA id CA4CAA0CB0;
        Wed,  8 Apr 2020 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smaract.com;
        s=default; t=1586329924;
        bh=OsEz6GvKjLOkUJz9ClB3aeaK3X9SVPOosZop1Yctfn4=; l=1271;
        h=From:To:Subject;
        b=kzQ1axBS3mpOxWidODdc1Gl0X+Qj1Y6Ha2Ga3yZixYBF6qxaSEro7+LGLIvGyqTPU
         9wDgxcySGYzjyPCYAM7zsT6tcTOQtYRm/EzlttIDM+JndCuIi+lndATpCApTDx2QXr
         uccIawjcpxwc6gTbrJtSPZ5thr9ONXFgsy5mVOAk=
Authentication-Results: smaract.com;
        spf=pass (sender IP is 213.168.205.127) smtp.mailfrom=vonohr@smaract.com smtp.helo=mx1.smaract.de
Received-SPF: pass (smaract.com: connection is authenticated)
From:   Sebastian von Ohr <vonohr@smaract.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Add missing check for empty list
Thread-Index: AQHV8VxxdjMBtKwDjUiUwfzZyHoPo6g7hG2AgAAGXQCAMfPDcIAAaXeAgAEY0ZA=
Date:   Wed, 8 Apr 2020 07:12:03 +0000
Message-ID: <c0883a291b5940b6b1ecb14b072ffc15@smaract.com>
References: <20200303130518.333-1-vonohr@smaract.com>
 <20200306133427.GG4148@vkoul-mobl>
 <CH2PR02MB7000C592992EEFBFB01D5735C7E30@CH2PR02MB7000.namprd02.prod.outlook.com>
 <c12c2321f9d5407698b9992b9a375966@smaract.com>
 <BYAPR02MB5638F1A9A1B68C0FA534E07DC7C30@BYAPR02MB5638.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5638F1A9A1B68C0FA534E07DC7C30@BYAPR02MB5638.namprd02.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-PPP-Message-ID: <158632992390.35687.17539552563877992014@smaract.com>
X-PPP-Vhost: mario.smaract.com
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> -----Original Message-----
> From: Radhey Shyam Pandey [mailto:radheys@xilinx.com]
> Sent: Tuesday, April 7, 2020 6:04 PM
> To: Sebastian von Ohr <vonohr@smaract.com>; Vinod Koul
> <vkoul@kernel.org>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>; Michal Simek <michals@xilinx.com>
> Cc: dmaengine@vger.kernel.org
> Subject: RE: [PATCH] dmaengine: xilinx_dma: Add missing check for empty
> list
>=20
> Thanks for reminding me. Somehow I missed it. You mentioned in one
> of earlier thread that this bug is introduced it using dma_sync_wait to
> wait for DMA completion. So to reproduce the issue in xilinx axidma
> test client I have to replace issue_pending with sync_wait API?

Yes, dma_sync_wait triggered the bug for me almost every transfer. In the=20
xilinx axidmatest this is probably best achieved by adding dma_sync_wait=20
before the wait_for_completion_timeout. I encountered the bug with your=20
xilinx-v2019.2.01 tag. On this tag it actually crashes the kernel with an=20
invalid memory access (because the residue is written to desc). With the=20
current driver version it probably seems to work fine. You might have to=20
add some debug print to verify that the active_list can indeed be empty in=
=20
xilinx_dma_tx_status.

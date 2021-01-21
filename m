Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAB2FE890
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 12:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbhAULSw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jan 2021 06:18:52 -0500
Received: from mail.v3.sk ([167.172.186.51]:48630 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730101AbhAULPQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 21 Jan 2021 06:15:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 340C1E0AA7;
        Thu, 21 Jan 2021 11:00:04 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LTSdPkWLBlUP; Thu, 21 Jan 2021 11:00:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 88848E0A3E;
        Thu, 21 Jan 2021 11:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sq0sSr0l1Cwm; Thu, 21 Jan 2021 11:00:02 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 35F16E09F4;
        Thu, 21 Jan 2021 11:00:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH 0/3] dmaengine: Allow building MMP DMA drivers as modules
Date:   Thu, 21 Jan 2021 12:03:53 +0100
Message-Id: <20210121110356.1768635-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

please consider attaching the patches chained to this message.

The last two are straighforward Kconfig changes that allow building mmp_t=
dma=20
and mmp_pdma as modules so that distros that will choose to enable the dr=
ivers=20
will not add bloat to their kernels for other platforms.

The first one gets rid of a symbol that would be exported by mmp_pdma,
because it is entirely unnecessary.

Thanks,
Lubo



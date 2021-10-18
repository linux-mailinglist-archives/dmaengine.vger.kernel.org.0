Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08450431615
	for <lists+dmaengine@lfdr.de>; Mon, 18 Oct 2021 12:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhJRK26 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Oct 2021 06:28:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:27241 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhJRK2z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Oct 2021 06:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1634552791;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=bua4qRiW+JEJUeLGwWodyTqYPgYZUApgEu65ss/BRko=;
    b=laXcJ6YeDgFicYa3wx6eCTt4Egkt5YT0r+WTe4n82pURVGSFjfyEkb1I/Kje6XRtq2
    YMzYbN8wLL5i8fHoYr3C3jaCdWVLe6piPnHrco7pJJbeBGbPI+nAowLrxvlj2oSKRRLR
    k4NEmiS0E9mfdqbuDRES6kPZBr5p4Y3wID4k2VlFfzaebkUNGRDw/6ITH28udNuzOUOE
    9Px03FyBEan4oubS8RrEL2pkcyCRdl+YU5eteFKSifg4DLJUp88wtyarg2UsdyxQEe1g
    rvzIgu2IQ3AWBa4qfFYW59xTnDH4eMLFRdfB0PlseRbZHb2PTfMm3cotnI/OR37BQ3dp
    wbGg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQ7UOGqRde+a0fiL1OfxR"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id 301038x9IAQTVQ2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 18 Oct 2021 12:26:29 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 0/2] dmaengine: qcom: bam_dma: Add "powered remotely" mode for BAM-DMUX
Date:   Mon, 18 Oct 2021 12:24:19 +0200
Message-Id: <20211018102421.19848-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The BAM Data Multiplexer (BAM-DMUX) provides access to the network data
channels of modems integrated into many older Qualcomm SoCs, e.g.
Qualcomm MSM8916 or MSM8974.

Shortly said, BAM-DMUX is built using a simple protocol layer on top of
a DMA engine (Qualcomm BAM DMA). For BAM-DMUX, the BAM DMA engine runs in
a special mode where the modem/remote side is responsible for powering
on the BAM when needed but we are responsible to initialize it.
The BAM is powered off when unneeded by coordinating power control
via bidirectional interrupts from the BAM-DMUX driver.

This series adds one possible solution for handling the "powered remotely"
mode in the bam_dma driver.

For more information about BAM-DMUX itself, see the series on netdev:
https://lore.kernel.org/netdev/20211011141733.3999-5-stephan@gerhold.net/

Changes in v3:
  - Split dmaengine changes to a separate series
  - Address review comments from Bjorn

v2: https://lore.kernel.org/netdev/20211011141733.3999-1-stephan@gerhold.net/
RFC: https://lore.kernel.org/netdev/20210719145317.79692-1-stephan@gerhold.net/


Stephan Gerhold (2):
  dt-bindings: dmaengine: bam_dma: Add "powered remotely" mode
  dmaengine: qcom: bam_dma: Add "powered remotely" mode

 .../devicetree/bindings/dma/qcom_bam_dma.txt  |  2 +
 drivers/dma/qcom/bam_dma.c                    | 90 ++++++++++++-------
 2 files changed, 59 insertions(+), 33 deletions(-)

-- 
2.33.0


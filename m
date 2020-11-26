Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C52C5C1C
	for <lists+dmaengine@lfdr.de>; Thu, 26 Nov 2020 19:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404646AbgKZSqK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Nov 2020 13:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403877AbgKZSqJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Nov 2020 13:46:09 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B51C0613D4;
        Thu, 26 Nov 2020 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Jm9WExEEGbZnOC+/zAJaeZ73Cvbu8YyRGJ7tUNH6vk0=; b=wfQmoh83XQfT54jh1iV8LauzzD
        n/z69omMALivwYrURu1uC1lvMahX4fBJbr5KA8EH8Unhtw68sKPC4XSLrBEXOFAZKYdNQxdRXtIIN
        2ztH/xnuenTCPwXK7T4OFXz4ODJtVMBVJPdaLJjJIdm63eGVfunBKgrFT1YTrDs0tiGq/G5KuVb0+
        DXtVntH1sLNUE+iwNt6kBT2qtgPQ6oXF+wyzBy9wJNJHCGwsEnnEieSsLToXobr2rh9JWW53rVWRg
        wjfNoNoqiNrlMYTdb/iwjuz5eLg4spQwTP81lDvYR9Fc/vO5FTzP6zkyEUjd9D5ZiNOUnmEe43uiZ
        PWLS/B2A==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1kiMHK-0000KY-OU; Thu, 26 Nov 2020 18:46:02 +0000
Date:   Thu, 26 Nov 2020 18:46:02 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: Fix ADM driver kerneldoc markup
Message-ID: <20201126184602.GA1008@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Update the kerneldoc function headers to fix build warnings:

drivers/dma/qcom/qcom_adm.c:180: warning: Function parameter or member 'chan' not described in 'adm_free_chan'
drivers/dma/qcom/qcom_adm.c:190: warning: Function parameter or member 'burst' not described in 'adm_get_blksize'
drivers/dma/qcom/qcom_adm.c:466: warning: Function parameter or member 'chan' not described in 'adm_terminate_all'
drivers/dma/qcom/qcom_adm.c:466: warning: Excess function parameter 'achan' description in 'adm_terminate_all'
drivers/dma/qcom/qcom_adm.c:503: warning: Function parameter or member 'achan' not described in 'adm_start_dma'

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 drivers/dma/qcom/qcom_adm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index 9b6f8e050ecc..ee78bed8d60d 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -173,8 +173,9 @@ struct adm_device {
 /**
  * adm_free_chan - Frees dma resources associated with the specific channel
  *
- * Free all allocated descriptors associated with this channel
+ * @chan: dma channel
  *
+ * Free all allocated descriptors associated with this channel
  */
 static void adm_free_chan(struct dma_chan *chan)
 {
@@ -185,6 +186,7 @@ static void adm_free_chan(struct dma_chan *chan)
 /**
  * adm_get_blksize - Get block size from burst value
  *
+ * @burst: Burst size of transaction
  */
 static int adm_get_blksize(unsigned int burst)
 {
@@ -456,7 +458,7 @@ static struct dma_async_tx_descriptor *adm_prep_slave_sg(struct dma_chan *chan,
 
 /**
  * adm_terminate_all - terminate all transactions on a channel
- * @achan: adm dma channel
+ * @chan: dma channel
  *
  * Dequeues and frees all transactions, aborts current transaction
  * No callbacks are done
@@ -497,7 +499,7 @@ static int adm_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
 
 /**
  * adm_start_dma - start next transaction
- * @achan - ADM dma channel
+ * @achan: ADM dma channel
  */
 static void adm_start_dma(struct adm_chan *achan)
 {
-- 
2.20.1


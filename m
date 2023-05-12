Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC17010D0
	for <lists+dmaengine@lfdr.de>; Fri, 12 May 2023 23:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbjELVRQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 May 2023 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbjELVRO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 12 May 2023 17:17:14 -0400
X-Greylist: delayed 2660 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 May 2023 14:16:43 PDT
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F59FD86B;
        Fri, 12 May 2023 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lK+PuqG/PZ+bMj03Uv3D+HZoOeeeJLmEi2QLkUdPOZg=;
        t=1683926203;x=1684016203; 
        b=ZRFnGzUSRrYrmQ/v4HBirm8RfJdJW8MV66/kRVxXEdZR5cxnCr3yPT/oDUEI2i+2QNO0EpGUPH7YCDNRUr1506xvCwEC7IUUMHWyXLBaLiFqZIuWf9uT2t+FbrMz1nbuGo3uYcHH4aRJYs+4U+N/UAHGiFFdXaklyYsVyT+nOqrL1IjMGeB9CRprvIJKfLNlCROcwG8Tcxt8oSXGciPA+0H248926n1yz4TZKk7U2AcAhhcdRxLMzGHiJ6AOlg/t2vXvPkZHVA7DUwDcsjqOhRUNabg8ZJQeY5tq4cG3Ghja1LIwU+CAMo7ah0GwnaLWu6kvhvq4km/Z6EbN5yHngA==;
Received: from [10.161.55.49] (port=48596 helo=smtpng1.i.mail.ru)
        by fallback19.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1pxZQq-001ItA-9o; Fri, 12 May 2023 23:32:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lK+PuqG/PZ+bMj03Uv3D+HZoOeeeJLmEi2QLkUdPOZg=;
        t=1683923524;x=1684013524; 
        b=giunTIeifrV1WsLu/7Zn5qvD9772DsJTwfN1OSqh1E19rozYNYIiuSA5kU9HjKR3pCaqliWM3OmB1n9RX73kOJZRVeelfFl/A4PansB6c6cC0vf3D7UmcyCZx6StBADM997r4ceqdLnmGzU6EHgRpnXvw4wQl0lEVh8/LJDziiVKOneCL5R3Q7AosHwcLFzjfc6fwufxF3tW0Sup2MJl96AL6v7B8nlqZsOH15h1lNxSC49wZyldB/Z6xBADz5OE4bhJCwJPfJCDdmjKyyj+SjuqPbyQXP0zl4HbeuuLRc0vM8A46eb1Dug606w9XQAv0ic3KFVzhg7P8IcYtiSBEQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1pxZPl-0006Yx-OW; Fri, 12 May 2023 23:30:58 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     dmaengine@vger.kernel.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: dw-axi-dmac: drop useless apb_regs messages
Date:   Fri, 12 May 2023 23:30:46 +0300
Message-Id: <20230512203046.96919-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD92B2351A05AA37E8C9BC00D86A046157D6099CAA8803524B300894C459B0CD1B91E891992F5778DF00FCD0F2A2F6DE3A558CA1F617DB34F2432F1CFC60563ED00
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D4C8253EF564ECCEEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F757A79C3007ACA28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88ACE8037EF8144AC9AEB94AE6D4B875B6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7212612128AA291179FA2833FD35BB23D9E625A9149C048EE902A1BE408319B296FD1C55BDD38FC3FD2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BFF6C1D329F95ABD4A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249E5E764EB5D94DBD4E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6753C3A5E0A5AB5B7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5EF76BAC35411AC8864A5293F74C880E3EAE5440BC58813D4F87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF7C5FD2CA3C4C0EA444D11449886594C9F87BBFFC3ABBBF47A199EE618BC606C9E98901B1639BBD6317FE5FAEF308060728D8493C4F6E23BCC0B07C5A4A27588306EEC8038AF5C160
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojSxP3OVHGGxEaUyKCfIHZwA==
X-Mailru-Sender: 689FA8AB762F73933AF1F914F131DBF5C6D525BB210F34E1949B2C900674031398CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4F94BC29E10CAA32028F76D7ACC9C877ABDCFC54178319ED568F3CF0E9FE49B69E99F2AC85445CF8A0BB90AAF709EAF7E6A26C623EBBA28658B0FC916A5BA051E
X-7FA49CB5: 0D63561A33F958A5020A52AECE418A5A103E5EA9C703B0B60C13F039F00C03A3CACD7DF95DA8FC8BD5E8D9A59859A8B63E5666BE991EB762
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdFotv4hLRoZviRObnacbF6w==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If apb_regs is not used then drivers prints useless message in
console in every transaction:

[  217.527569] dw_axi_dmac_platform 10000000.sys-axi-dma: apb_regs not initialized

Drop this message printing to reduce console noise.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 6937cc0c0b65..d6899481803a 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -356,7 +356,6 @@ static void dw_axi_dma_set_byte_halfword(struct axi_dma_chan *chan, bool set)
 	u32 reg_width, val;
 
 	if (!chan->chip->apb_regs) {
-		dev_dbg(chan->chip->dev, "apb_regs not initialized\n");
 		return;
 	}
 
@@ -523,7 +522,6 @@ static void dw_axi_dma_set_hw_channel(struct axi_dma_chan *chan, bool set)
 	unsigned long reg_value, val;
 
 	if (!chip->apb_regs) {
-		dev_err(chip->dev, "apb_regs not initialized\n");
 		return;
 	}
 
-- 
2.39.2


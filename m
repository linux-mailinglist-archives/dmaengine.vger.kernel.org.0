Return-Path: <dmaengine+bounces-2041-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D879B8C77BE
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F88D1C22A42
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2481474AA;
	Thu, 16 May 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="f8zPVTPn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD828680;
	Thu, 16 May 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866377; cv=none; b=I82urFkYGXAI/ummY9CNJ46Jykd8NEMWDsvdRQOgID2g9L4xk9UsucP1SIb5sERd6RQjYGs2FdKHu8HPMSWIkjE+uztFi8P5qyDuGw7+ASHLGwQXHZikH8xlqfR0bwC4WOwgAq0VSiDmuhRe7D4HiR8dPPz5pu3QUixRuKJdtQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866377; c=relaxed/simple;
	bh=jApHfm8/bGAOo7hSMkRKiQcKQv8hcQiKeAJ//Yh4Vwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsw8I6vhTpI7GQPN3M349TdM3K3TJ+jZeEOGw60T2UfAmHnqMSFEniPT9eZPSEFjN913Ss5pT6JTdb7VMt6fhu5B7obvw9yabe/mqL3tOhCTV4bEcw0499qPFmQf1d0WSSZWsqbRB+YKXF2KcMcu8iwUpCjxCmlQYEcsCjCQpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=f8zPVTPn; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=4CckRCztzC0FnG15EZ5xwjbQEYuzYOC91cP0DsJpFpQ=; b=f8zPVTPncpSQqRqt
	YdvW4tS99vg2+3kaJ6Aa9k44yxJ4CKRVp8v6rw8BLmbzkJ1TAlWVicfL1r+sM13v8Z/e8iitifsJq
	74ThXqQbXTWw1CpafjHTxg8zGQ7mVHz3CMvagpdy5kTNCmsOFYEWsY52Ne2M/SLVK5tSAGhm52XdW
	dctqbIYeSsO6kbM9pRoLiM2u8iyzhe34jzFDm8NfK3MfoYxNSVnLFyPMOvANLkpOrn0SwhFReNdvP
	RVan5dDeLJfh/X03pnNozjMdcZTnC61zUbSbU7LX9hycnuZweYkQtkN55lzM7jSfV2+CBOlzKoWMD
	HKFVWBzwBh1IVc5B1A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s7bE3-001EmN-1u;
	Thu, 16 May 2024 13:32:52 +0000
From: linux@treblig.org
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] dmaengine: moxart-dma: remove unused struct 'moxart_filter_data'
Date: Thu, 16 May 2024 14:32:50 +0100
Message-ID: <20240516133250.251252-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'moxart_filter_data' never appears to have been used.
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/dma/moxart-dma.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index c48d68cbff92..66dc6d31b603 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -148,11 +148,6 @@ struct moxart_dmadev {
 	unsigned int			irq;
 };
 
-struct moxart_filter_data {
-	struct moxart_dmadev		*mdc;
-	struct of_phandle_args		*dma_spec;
-};
-
 static const unsigned int es_bytes[] = {
 	[MOXART_DMA_DATA_TYPE_S8] = 1,
 	[MOXART_DMA_DATA_TYPE_S16] = 2,
-- 
2.45.0



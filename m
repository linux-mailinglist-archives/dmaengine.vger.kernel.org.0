Return-Path: <dmaengine+bounces-3807-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D319DB291
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 06:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8B5161199
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 05:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CB13B780;
	Thu, 28 Nov 2024 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="UKiIRcXo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="sa9rMu8q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="Jc4vdLq8"
X-Original-To: dmaengine@vger.kernel.org
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CA412C7FD;
	Thu, 28 Nov 2024 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772538; cv=none; b=hDiKLE0UqImeogumVfl2oKbRzP+2XkgbCCOsaziFzWuUep9zeH+Qj0fQzwkSl2gRcR6CRDH1J6P98gQBHIIq9zQQ0jo/5GcrNJOx2j2rE/DSuUwoHv1E09WuTBLhKF0QrhvLH+kyqa2rITmVVIIgtR5k9r5pBzTcZSzNEt94ySU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772538; c=relaxed/simple;
	bh=g8a48EcM+AVuU9Vx36qEdEsD9fWzzqOPqTFCMFku50w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLikBbmZ0A/2RoUUtecxEJgKHHcGn5AfBYSNgutkAWnDYTwrgZmo+GqQMrs/I0aUieLFhya1qlXSi+kQ7gwQ3rTVc9EvwS7n06EIObgFk+LkxVfR7KFNq4wqjEvvovYLkD/WvbSaicjr44kHv7y8zIJJGQTv6xgo21yVkpKEWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=UKiIRcXo; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=sa9rMu8q; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=Jc4vdLq8; arc=none smtp.client-ip=79.137.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8000Jc4EcpgBD3+O+zLd4SjqEGa0myYfCDXx9OG36/o=;
	t=1732772533;x=1732862533; 
	b=UKiIRcXoTPvpLca7Vc8BqgsoimPeAx4rK5MX9hqkUR90L6gg+GG9TkFRhgyqAW9ereVcqLEeiP23zfFSJQ0rRrItMa7irfCi4Blz+MRpeD7mki4C4nVihtQRZIKM84VWOWV85MKgAF+cfIdNuM7vQROWyR9YO8W3KOwBqCgKY9k+64MlpWf27BwDELGmYJGyR8PyL1HAwCwaAkGK8d+dmLKBrD+fFiUf+ag7wi+bXy39N5p9mc4K2nriDH+T4OpkeRNOO7rJOr5RKwfalZtGuZTwTkgInP9wUVoR8O+1LWsu0bdBB15ud5BstHs39bGWzFBDOrLO6or2EZy6JS27DA==;
Received: from [10.113.244.107] (port=56470 helo=send55.i.mail.ru)
	by fallback20.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tGWgd-007Wcm-3e; Thu, 28 Nov 2024 08:03:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=8000Jc4EcpgBD3+O+zLd4SjqEGa0myYfCDXx9OG36/o=; t=1732770211; x=1732860211; 
	b=sa9rMu8qCjGkqyLFXep4UVTP2rJoCxh7EpGbGaH1JfpB187kivs8Z90eOymlDeCrA0hIZ4O4PkU
	EYClE9SZ2sPEFavYu6DdKfU5u848fBDIiAYQKSnMb6eEuFkXy1nMfK3X8oCEJDGpRJbgJdd1pwgFI
	nzLzsWJKX0fBrvYxspMijviCpJKxgRmbyKlT63KvIx3EEFmhdTzwiy5JwS/qOKTZEdDBvoPKVlcWF
	i9N6oJ0qC2VvEdxaD5YCbHrzACSPi4jZcYf1PnIYgM9Vbrk+uUt1HeFzwmQ7j153Ed8oO1C6iktJt
	prxm3b3qxB6dgSfRgfmk8k+Q0ro2bJnTMfyQ==;
Received: from [10.113.87.111] (port=54244 helo=send103.i.mail.ru)
	by exim-fallback-8c87c6976-nf69c with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(envelope-from <fido_max@inbox.ru>)
	id 1tGWgU-00000000P0P-1Yx7; Thu, 28 Nov 2024 08:03:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=8000Jc4EcpgBD3+O+zLd4SjqEGa0myYfCDXx9OG36/o=; t=1732770202; x=1732860202; 
	b=Jc4vdLq8T23zNwF7QbIenByu0Vj5KxkJBAP6NIkY4ZMrVMLi6lNuKEV3feIoKz0X8+nTnDdnLM+
	sUuFqzNP4TIUgoK2AheURs/49sfEotJEKdRwuwvWjY4mVGtMZ+XEwqZrAD/YUTjiRAQBQAb6za6Ow
	Hyp45ifb8AJeUktpE4gV467iyRGUXTc9ibwRqEgW/v3/cXcvwVmx2Hs6rZ/ahPe34rRsGKfYVoPR3
	STYDa59a6MmXBfutXwtSCPtIdDJa/F6P1An7zwtM8ZNrd6CLY+9F5/muEcvEyVL2nRGHxRP84dqEg
	vh/n/DLDtAiLKm7JWPZx6PvG3WMawNQB5Wdw==;
Received: by exim-smtp-78d78789c6-mlnkw with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tGWgE-000000003d6-0AzY; Thu, 28 Nov 2024 08:03:06 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	pandith.n@intel.com,
	dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kris.pan@intel.com,
	Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] dmaengine: dw-axi-dmac: fix snps,axi-max-burst-len settings
Date: Thu, 28 Nov 2024 08:02:59 +0300
Message-ID: <20241128050259.879263-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97DF634AB044F3A907E3AE3D432875EDC98B7E504FBBB9CF100894C459B0CD1B9F2389BC223EBEECCA6D5EE0DB6E1EC8D778098BE51C57FFBC3FDFF10E9E3586C16B550D20AEFFB87
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75909A206F8DB96D1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B323FE155BC226618638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8511CB73ECB8387D4A3C56C9BD60E2DA31729AB5A020325C720879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C06FD1C55BDD38FC3FD2E47CDBA5A96583C09775C1D3CA48CF4964A708C60C975A117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE77A825AB47F0FC8649FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA73A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4930A3850AC1BE2E735F43AACC0BCEB2632C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5AB0348031C4ABE225002B1117B3ED6968B3F5479DDFBFA7ACCE9A60C8CB01D7C823CB91A9FED034534781492E4B8EEADC0A73878EBD0941BC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF3C5E3F1247E737A5DFEA82B927694E7C9FCD021FC4F069547077FF5214860E40AE7801A017AB3E4ABDCC763D930D6EFA9E152F28BD9B98AF4BBC8D017325D0A05D9E2B9A2E7C2EC036DDF96CB8D31E6A913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojA97iaBGbkJ2BoKPW3HTZ9w==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA219D67F144E7FFDE5B54C17F37CF7F6C09E7AFCCA499703051D90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4935A4DD83856F5F2FB468968E2A111388496A54F7D82D744049FFFDB7839CE9EA045B0A3CAF751E280511A1B5114F691CAC4C43CF70E4315F756D43522314BB4C7E3406AFA4B58FF
X-7FA49CB5: 0D63561A33F958A5DA64E6732EDB1ADE5002B1117B3ED6965AB0D2348C84F6E90CC8CF6E17EE77BC02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSommBmn3M0hsgyxHfUpwjuv
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4935A4DD83856F5F2FB468968E2A11138CD10D46885EE5561049FFFDB7839CE9EA045B0A3CAF751E2DE0FEEF2F7CB6B306D74EC5E8ECF97947E0E5435BEC6C054
X-7FA49CB5: 0D63561A33F958A5FD4D3890BB6E8DE32D1DA6AD6FF8CF8BB1E2BE012B91DE2DCACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSrdw9YFAmD7Q3vnsmttD4RG
X-Mailru-MI: 20000000000000800
X-Mras: Ok

axi_rw_burst_len allowed values range is 1..256. Then this value
goes to ARLEN/AWLEN 8-bit fields of lli->ctl_hi. So writing 256
leads to overflow and overwrites another fields in LLI. More over
ARLEN/AWLEN are zero based (0 - 1, 256 - 255).

Fixes: c454d16a7d5a ("dmaengine: dw-axi-dmac: Burst length settings")
Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..9aa79e9b49ca 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1437,7 +1437,7 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 			return -EINVAL;
 
 		chip->dw->hdata->restrict_axi_burst_len = true;
-		chip->dw->hdata->axi_rw_burst_len = tmp;
+		chip->dw->hdata->axi_rw_burst_len = tmp - 1;
 	}
 
 	return 0;
@@ -1550,7 +1550,7 @@ static int dw_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
-	dw->dma.max_burst = hdata->axi_rw_burst_len;
+	dw->dma.max_burst = hdata->axi_rw_burst_len + 1;
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
-- 
2.45.2



Return-Path: <dmaengine+bounces-3834-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464229DFA28
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 06:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B5D28165E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 05:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714F1E22EF;
	Mon,  2 Dec 2024 05:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="PC7xceuD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="ZYcdg12b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="Wa9VlkmC"
X-Original-To: dmaengine@vger.kernel.org
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8251D7989;
	Mon,  2 Dec 2024 05:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733117026; cv=none; b=En3A+soSXwwCjh26qoXCnXWR1f8Oqd3kGs6dqcCX5XwdvhFKatlBLNoUhKVyP8EndJozBmqmug4kOtHU6ciYhzxzL4yYZsuGwtp9x/r3A/PI+9VMW7sT8uZXOw83tzlZTyLnIAz+cY5P+W88B8b9nLAvD8pcXa2HOYFMFpMDO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733117026; c=relaxed/simple;
	bh=dAzkkXOklX9l4PdTlywrHPxEZATQBRyKJW+NdwDTQL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKlAHsHH2AxYu67LXuqMNWvvIK2vnC37sWWaqWN/UIfj/980sHcH2uYD/4/Z+hiKUmZ4EBxzv4DPpXEIODrPbyl6U8hAFDNje6I0qyA84mq7RDd4ZfrQGkHz+ctVcaznkBmAKzyCkBN5azqE1wHjMTXjn3N/M6AJsacyA4g/exA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru; spf=pass smtp.mailfrom=inbox.ru; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=PC7xceuD; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=ZYcdg12b; dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b=Wa9VlkmC; arc=none smtp.client-ip=79.137.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=sLzjaLNccp32xqzzLUxj/GPXzOiSBe3O4mADvlCTRrw=;
	t=1733117022;x=1733207022; 
	b=PC7xceuDe+rcSWDPDfRcZj8GffN571VxsI/qUUCVr1eiz9uXPOCemdmeXJM8syNxB2grLfct+NXt6UF7MhCA1zNiZKtSsrjjl7vugUckrl2GbL+ktlgL+R8MZWKpPJ5gsQ4CiCFgLcfHWczi9/wMjn4dWcVrgceKju0PcAbCVod/M9FUdtrJYnHt90+V6F0NmdE64Ne1KvWDTb/BzvbDMuGx4asxX3K9lKDcen+oz5TGfQhiIWWaIwIk567uh8bC5sETT2brckWsQ4LqEImQY46Ff4hdZjmsHNtBkKN1V7Gn9HB3NfvI/ohg4BSFDkFjXRsKXeY2A0coXicrVQNJWA==;
Received: from [10.113.74.62] (port=33090 helo=send239.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1tHyTw-0074Nc-9o; Mon, 02 Dec 2024 07:56:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=sLzjaLNccp32xqzzLUxj/GPXzOiSBe3O4mADvlCTRrw=; t=1733115384; x=1733205384; 
	b=ZYcdg12bQ/JWoUNzBV2U4oyiv8Rkj/SSrPe84HSws3WfWaD2jqqlElEvY/7cCEERgZpWm0L8b4G
	6vEc5FLfEu4B5ALg9sAtRrLIQyfd+JZZT1uqW472Ld2AOwK2F7pRnnOZ5ryogGHWjfJKRh1Pxd5wx
	SOYVcm2XqcTuXY77UphGEoIlevA5CtojoEIbKbeK600wEu4HMsmirLqv6sgNhghn7qB72XLymJAt+
	PsahqjRThqmDW+qeHfS5yCBWHyp/EXHjVxKWkchT2vxTa+RJoqc5003pkB0NxqU0l/TIsNIN9EdIN
	EH8f4kBaHd/XTNbLA6vGizieCh0LPavmGXPA==;
Received: from [10.113.30.228] (port=60728 helo=send243.i.mail.ru)
	by exim-fallback-7945844578-tv4xc with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(envelope-from <fido_max@inbox.ru>)
	id 1tHyTj-00000000LHM-3hqF; Mon, 02 Dec 2024 07:56:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=sLzjaLNccp32xqzzLUxj/GPXzOiSBe3O4mADvlCTRrw=; t=1733115371; x=1733205371; 
	b=Wa9VlkmCujgePXK96OmAU/ynVcrXdzBxF8RTgLhlSVnexi4/9QTRYGAZ57TqW+qeYLo92qmGJFw
	OKf2HUOeEZlcye+Wrg1ROa/iVenty17kNiqN2NYUJibxD5Cw/yCaU2FSf+3n1pujz4CcL6PiEcwYT
	2v4L79nzEAP5yXoaYQimTeF63diRsgCSQWzcmjDIQPHwB08tXFkrjEoFmnPRt2Wcm337DYvZYKox4
	agfpClCQaqJTG71dVwpZou1dl4mBNXuJGGGrRdpWjawdSO1UDASnN88Lmt2XzlL+JYguyF7l9MsZK
	QApJk+5DE8XL/kilqseSG6vISnknjNsGdUzw==;
Received: by exim-smtp-66468c9cd6-6v6ql with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1tHyTT-000000006VA-1BnW; Mon, 02 Dec 2024 07:55:55 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	pandith.n@intel.com,
	dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kris.pan@intel.com,
	Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH v2 1/1] dmaengine: dw-axi-dmac: fix snps,axi-max-burst-len settings
Date: Mon,  2 Dec 2024 07:55:47 +0300
Message-ID: <20241202045547.9818-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD934EED3D1897221AD32F41157CD9C3A1FA2C34AA9AB28E7B5182A05F5380850404616508DA2EC2DA33DE06ABAFEAF6705664CF6F8D54C7E27B50FBF7DA1CB3A5EF387DE8544A20E12
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70993CE289E4873FDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DC5FF0CF1FFF13268638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83EA14B6A5C935649F716F10B0CBCDC51E6AE85A2B6D09E1820879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FA18204E546F3947CB861051D4BA689FCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F924B32C592EA89F389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FCF1175FABE1C0F9B6E2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B9F5955FECEF5819E75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A522792620B4E01B3C5002B1117B3ED6960DFAC1758FA4EA231A1B8FE1FED62FE8823CB91A9FED034534781492E4B8EEADEF0AF71940E62277C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFA5EA015AB614DDBB47A8DC7D3D12608C545775C061A83E9FE5CC910D90DA62C98926F27D50C27B5D092E025A8769729B5DDA9A53FB2FE712DBB026FB9353932D4C1639E2FFCAC0F836DDF96CB8D31E6A913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojO1VuGdGE5q2FUbKlbhb4dg==
X-Mailru-Sender: 689FA8AB762F739381B31377CF4CA21983224C40AF0911AE5A9DC70946A4CF8768C90F5F3A63D40990DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B43FC0CADAC5862D10BD418D8BCE21C1397C3DD45D47DE4746049FFFDB7839CE9E803AC44C7DE65AB8E8E6C86354779DE13AF771003FABD2538F0C131328B23C47580F9C61F3C0725B
X-7FA49CB5: 0D63561A33F958A50F2E8A76274BF1F85002B1117B3ED696F3C4315566DF98561BC0F5E4D9A341CB02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpR8lcNIeo9DQyxHfUpwjuv
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B43FC0CADAC5862D10BD418D8BCE21C139F979BC2442DB433D049FFFDB7839CE9E803AC44C7DE65AB88C6C39C112E502417FEB9BBB84706903A1C93099D1061102
X-7FA49CB5: 0D63561A33F958A5EFFDE89FEB283DC4EF07C9173785D1390C13F039F00C03A3CACD7DF95DA8FC8BD5E8D9A59859A8B6BD6F1B7A61036D3B
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u6NqYXWMR0/V85CnFjCYTu9APdQH0PvpnP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSppPd5MysOO3rRFuIOw5Q1i
X-Mailru-MI: 20000000000000800
X-Mras: Ok

axi_rw_burst_len allowed values range is 1..256. Then this value
goes to ARLEN/AWLEN 8-bit fields of lli->ctl_hi. So writing 256
leads to overflow and overwrites another fields in LLI. More over
ARLEN/AWLEN values are zero based (0 is 1, 255 is 256).

Fixes: c454d16a7d5a ("dmaengine: dw-axi-dmac: Burst length settings")
Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..3454c98f6c0e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1437,7 +1437,7 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 			return -EINVAL;
 
 		chip->dw->hdata->restrict_axi_burst_len = true;
-		chip->dw->hdata->axi_rw_burst_len = tmp;
+		chip->dw->hdata->axi_rw_burst_len = tmp - 1;
 	}
 
 	return 0;
@@ -1550,7 +1550,9 @@ static int dw_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
 
 	/* DMA capabilities */
-	dw->dma.max_burst = hdata->axi_rw_burst_len;
+	if (hdata->restrict_axi_burst_len)
+		dw->dma.max_burst = hdata->axi_rw_burst_len + 1;
+
 	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
 	dw->dma.directions = BIT(DMA_MEM_TO_MEM);
-- 
2.45.2



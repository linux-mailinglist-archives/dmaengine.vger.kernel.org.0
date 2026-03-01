Return-Path: <dmaengine+bounces-9156-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ht6IG2So2nBHAUAu9opvQ
	(envelope-from <dmaengine+bounces-9156-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Mar 2026 02:12:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6B1C9F34
	for <lists+dmaengine@lfdr.de>; Sun, 01 Mar 2026 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45711301C169
	for <lists+dmaengine@lfdr.de>; Sun,  1 Mar 2026 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0D021B9F6;
	Sun,  1 Mar 2026 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0xOKR2sj"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A620E702;
	Sun,  1 Mar 2026 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327529; cv=none; b=FRKYQF/npwFOw7PYf2CmOmh/Hi1hnIEP89oVgnUgAh7Cey/0H0hNut2d8IUNURvPoqAnQQOhOKBcurWhAn3VwDTYm6A3uTrLwpogPXUf2NR6eJraZu4GNOwfaFtGnJ/b0IwoRm0VnvjNJyXTu/8x3Dy0Gam8pl5d3ypw/T8iUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327529; c=relaxed/simple;
	bh=FtJaM3RpeD51EWCUchyZ4hpoYlAF/X0MYilKS4HdvZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChPV7Y4wvLeAWKYRKjSW44Dn14nPoU8ypU5pIQp/T+WQ61CJbpwIw5+JuaWlNvuAwCHEwpKmk0HhWinUiUyHBoQKZG/l4Vgu9GmgOjBDlFCfWLA0zuRPOk7xd7+cxp/c/bstA3ek81xgjEoDSN3stDqIH30Y63/K/HBkdQX+XKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0xOKR2sj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=12C2nEyvjRtVXY+Q+8xIueyyUnlhdy20dYi3tPGyGYM=; b=0xOKR2sjBjTsqLUDTJHlvgvuoB
	DIZr29kqxwr5GC2QM9XPh24hXAtCdtL2vZ+xfuZYqs4BMpzVSRU9ki+3oSQ4CIz+rfkicvlp527gH
	P+DMwSTXEDiv5a6G8ArbD6IKqujiitWU5AMq9mm+oXFkxd883VTphp0bcNKEpqdIDinyiUWVq41rs
	YlIse2HWDdT9m3unl8tdfw3QAf7RRplqBIIPVK7RC5NZfmTdhOdKvxy0WEe9NY55bHHhJS8JRp5qp
	DJINqOIf+SYEnjMD6hdyVNaX+s2Rmm1dQw0sX0YJGM1Xj49ZmJE8MmJBdsjAZWOncE/zF5JwA8b93
	PLAJpqtg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwVLo-0000000ARS9-3QlJ;
	Sun, 01 Mar 2026 01:12:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: qcom-gpi-dma.h: fix all kernel-doc warnings
Date: Sat, 28 Feb 2026 17:12:03 -0800
Message-ID: <20260301011203.3062658-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9156-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C3F6B1C9F34
X-Rspamd-Action: no action

Add missing enum descriptions and spell one struct member correctly
to avoid kernel-doc warnings:

Warning: include/linux/dma/qcom-gpi-dma.h:15 Enum value 'SPI_TX' not
 described in enum 'spi_transfer_cmd'
Warning: include/linux/dma/qcom-gpi-dma.h:15 Enum value 'SPI_RX' not
 described in enum 'spi_transfer_cmd'
Warning: include/linux/dma/qcom-gpi-dma.h:15 Enum value 'SPI_DUPLEX' not
 described in enum 'spi_transfer_cmd'
Warning: include/linux/dma/qcom-gpi-dma.h:80 struct member 'multi_msg' not
 described in 'gpi_i2c_config'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org

 include/linux/dma/qcom-gpi-dma.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-next-20260227.orig/include/linux/dma/qcom-gpi-dma.h
+++ linux-next-20260227/include/linux/dma/qcom-gpi-dma.h
@@ -8,6 +8,9 @@
 
 /**
  * enum spi_transfer_cmd - spi transfer commands
+ * @SPI_TX: SPI peripheral TX command
+ * @SPI_RX: SPI peripheral RX command
+ * @SPI_DUPLEX: SPI peripheral Duplex command
  */
 enum spi_transfer_cmd {
 	SPI_TX = 1,
@@ -64,7 +67,7 @@ enum i2c_op {
  * @set_config: set peripheral config
  * @rx_len: receive length for buffer
  * @op: i2c cmd
- * @muli-msg: is part of multi i2c r-w msgs
+ * @multi_msg: is part of multi i2c r-w msgs
  */
 struct gpi_i2c_config {
 	u8 set_config;


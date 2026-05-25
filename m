Return-Path: <dmaengine+bounces-10808-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN9QFy3rE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10808-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:24:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 025855C65C9
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E8333006114
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EFC39B497;
	Mon, 25 May 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AO1VRlMG"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396A39A064;
	Mon, 25 May 2026 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690279; cv=fail; b=ZeP2QLQvDvqfcO+nO14A8Qded6fb6JfuN+WH0idoRz1qHbvt3JT5/CStOhjYoyMQjtj6wAnvawRz2B0om16HBKN4ayTQbTocMrujAXdL5ZPR8NHl6tSQPLV5gIA2koPdLFLthcK1q94n1GsB24FmGL7XvWNWSrsiY3O5RYOAnC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690279; c=relaxed/simple;
	bh=BhlbSzVTjpX5TQlhG7JJst6yc9LXtr2q6KrICIVTrak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l+rGINfybTYJhNv7/oiPcFMU2rkaqgb3h5bawfGsqCunaMM4q4QQeNTkAV48sDhrxdMA1aIMpnr+40/NhTsZTzdVsvZ5T8GyEOiuZ8JPuWZJhjVlDnEn/g6eCvUSJALsbDwDMeM5jBUgFySPvb3tXhEdY3LbFeLHZ+VkV51nVrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AO1VRlMG; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0D0XWAPpz8G/WrhupfjTKVSpDLFNPsFpiT1uyInnEBfJXdp+F1q5sf03lNohPY9ac9M80ESaMuVH7k5/2+utiUFCpLziS9loeAIpOamwkBmnukFciZI6QGUb0P0AX8B6TpIax9fJiHqk+dERMU2Do8IzFsjfaAr2gyrRLtynzJd2NMBpTnl5KGn+Mrb5aMTPP8w8hwu3pe7QcKazt3DSZlBHDz8w6elM16PeQmIvMDC5xrVF7Q3s1lDjw6roxIcliueH+D6N8kTbS2JRUAod+mK6Qkz9JIonqi87l0NchKXy41qdfSmmvgyLL6cxss7OW7tWwslOcN5mpVPXa0Nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxosVh7VJxxdhO7eIGTSiodIuvoaYGbgGfyrg7Lnp1U=;
 b=Mk/8d7xoFTHmqwC6QGgG8ZxWaouJUMBqAookWeQuQGa4Uk4rliA0JSxpt7R80tBJUhiKetGwP+Bq27agepqkuHJMSu4IWZ1V9dUwmoYY41EMZvO0PyZpJw2q++zq+YDBHF3FphZqgf+bBc4zpf/wd8TeWGp7IcxyPixNu0v8lh+9YvRcipnosqlqV6TR7/XOL1j5fhzGD6YxD3u2PDbzvV7HWiTflr44L02owYeunjZaoGhkWVmcp0zZBpDZ4IIJPYNrdpCIDQm1Cfd4quH1AUmenpZ1vmzUIfXkKuTZfe31BoeJOkbMRp0xzRRG1jbUc3jWkguOrNbZPCOUP36meQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxosVh7VJxxdhO7eIGTSiodIuvoaYGbgGfyrg7Lnp1U=;
 b=AO1VRlMGhWEfxQahFR1/8u+AyVXQ5XxXgDEX9HPru9Kkw6FRbvCKfP8g+QScIlRyEDv92NJuqTSKZAFL+UWOeIxuAV40mFTDGEJoj83HBKyCxDrEy0eFNqfpZE8DK0s06mnNuYn3Cvv0jI+CWRiQEW2mkC14XSck7FYXMlQt/AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4655.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] dmaengine: dw-edma: Add hardware channel filter
Date: Mon, 25 May 2026 15:24:09 +0900
Message-ID: <20260525062420.3315904-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0082.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb15a4e-e5bc-48c2-1ed3-08deba2649a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	fb3kqqsEEi8/GxoBSJHjDXrl8kRff7bMC6WySp2wu+PHIxDhvMqqdT7EWDXLzzyYLHI8hDkODfcvqDceS9D+NNam2JTD4TstVUp3bBCrS8G8YL49X2HjLks5AzFC1sQdNltUqSnlAjVWOQK+jhnkL+CHTymeHwFEnHlnPYXSdAcK5U1/ZLw7Mu8m4kfJ6DTXU2nD/aa2HhMb0CIzAseTYAqJMcSihA33PAgQ6tfOAnAsGIo6efBB+ip6DM7c/WH3zPo0XLgqS5IEArJICBT+5typEJypZfH0dAE8Tk1CXaWgDtdeKKfkWzQX3Ndq7Wj+b5jWKQGYJVmy5amGfc+Be23njyHu3TcRFqWIE/6euE2+ejBCSIYXOss7hdx8H6ee2bzqFtmfIjTxWAuY1zbNppkz/s/nC+OBX1wt4kUdmy8SuioVqXYvE5hfzmgAo5gelQjyHyLD9fYCzmL33TZT6AcgsUw4tIBfFKxqZHjmdDML8q8bKwzWndmBcLBk8QQowc6Wf9u27vp3sKh6CM4CdI8OhBl1FrItlEU1yCFJJJ1dpWTeoXYUMfC7c8zaJGVVoX2UlT48UnLhc2Vx86p6Xf7lG32qkIpFvlS1kXqfjXAxlYvfwoeIWt1lmu4Y0DgAV/z1Dd5hEC52VJqqT0SUs9UlweMdjWRh+exqMeEgVhspHaxa98cFOGibf6VrNeTh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hjJgWCZVO6lIG972pI27zMIIwMRDPPBAuRon+K7j/zR1QmUo91Ap4M/XfTO?=
 =?us-ascii?Q?OxBDdz1WRt1j/9lUOCf0qD1oQZiR3sUCICFAKin0iooZuH6dqoIg/tnXcDnU?=
 =?us-ascii?Q?XmUsYRAc7wdFaSq8eDqWy+Y9/2+2+/FxntaYuw32nLLPjbwEPUpzWCPtMOP4?=
 =?us-ascii?Q?f+XlfvfMb2aBEGFcs1JPhBxMaFPHg3VF3lYOO1EPFLrpLsIxuDpX3hhTnugZ?=
 =?us-ascii?Q?nO5wz1pUrieO13qjc8wkRv9iWKjHhbM46QTlPlEe4nlxJqY4Ne8SLPShTmCG?=
 =?us-ascii?Q?mWsJmfZOdknMR7nMdf0FJZJZhrIci3QFU5wefFueoYQPJj8NXubGkcQGDlvE?=
 =?us-ascii?Q?Vw8qMGLnC+8JT1v1+9kVP0celOp9nPZg7ddamZ0BND+URc9zkUAACTyOEWnj?=
 =?us-ascii?Q?8GmII02HRm7+T/cbcBpahtM69E9t7O5ibWk4H22xj6v/F+NVEDDXYzHvEsVE?=
 =?us-ascii?Q?4nAGeW3Y1wSKipN1nchSZbT3dlkJbzg/+JgiOLAG/g8MxjWvjdf6JhENP/gB?=
 =?us-ascii?Q?iQtobxUrFE3ahE6dULYRIGE2Gvlr4LDLdLSsJAu6sizgSyNlqL/4aU55rUgK?=
 =?us-ascii?Q?OoM69gpXqVB5xXZ7vGeWaVdv6lJoblELnUn+WTyUZWFtlKkbqboJ9S45Gkie?=
 =?us-ascii?Q?s4EENeKWqwkWOgZk952g9v3JiFYexqk7ZLt+psK4ZZYGeASURT0tdC4+EfPG?=
 =?us-ascii?Q?4hamgaBx+sxmpnlIzJrBmqCroDypY2woReg+Y3HlpZasWLMa45+7Q95BXbMC?=
 =?us-ascii?Q?k3L4y3qBk9fLeDTef8m03JOmBiJtfMho/Tr/KX6gobK7znJkDh5YbVG3X+NF?=
 =?us-ascii?Q?M0D/8kePd1wT4tQFIIVbOlAWzHLif5Ip5T6IyhZdlVBMx/TOp1GAeJCAirGA?=
 =?us-ascii?Q?e6rFGCOKY/Z7wyqq0hXzPpBWtc9tx4W2HIrDGm60CjynRJjeeplZu0qw5TcQ?=
 =?us-ascii?Q?D++9zlPiRj4u3wuen/2eRXrqjKvYBpTye1pYxXaY407PhUn+XXinVTOl54Bj?=
 =?us-ascii?Q?wGssUzEeZ2lBpENqNwd+snYkvtEkTFBxinEEgm651xbcxR7YvTz6Lta+FSZ6?=
 =?us-ascii?Q?4dBfoCAcumEfpOjNRWgJHZlpLRHXRbTBKPajL72e9UlDWEMNjmDBKqUoywc0?=
 =?us-ascii?Q?UWBmpRuylQsUjmuY3CMS0ydrj/I6lzL7In28ldFku8HPsFMehpgob/x++3Ly?=
 =?us-ascii?Q?yHYGEC+/GbtGXH80Y6g1RtNLrKN6kPSl0d7lcTaLhBfsIFRXcTWsr7GyGtvS?=
 =?us-ascii?Q?TrCNrGYL29NRoQ1k42yqQoRxEYsQFErIhfRZNS8QVPai2P8izFB3hjID/klJ?=
 =?us-ascii?Q?W3LsVP8TtHR2386hWgaVF6V/tP/yW0Z6uEnSCkcbBDT4pP6Nv8owIf+OEYTd?=
 =?us-ascii?Q?Y3TbKYngc5VgiFF2NRunC54krAMxApaMRudz2SJz6Sz9lJILyQjDMXrNJRl3?=
 =?us-ascii?Q?yfQ9EmuSN/vugRrNMawj0cgUKejq2gwWlgwKTx2VjHmUCRv8Ja6rY/OY751R?=
 =?us-ascii?Q?k+UZ5CEIiVZVZI5Nx+8l7kJqzL+e9+GevakgFFm3OLsTDPt5peG38ENLp4sV?=
 =?us-ascii?Q?WU9m1kzTJ5GIgez6ecXS//Ri/OggxWez1/UA/dviIHrv2OSBgHPCa5UckE7C?=
 =?us-ascii?Q?73GptiyT0sZQ3BlgYZk1qSbwBqEQveOTErCDBDTqA9/6ko88mOTcikWP6ffS?=
 =?us-ascii?Q?A2OUghBpGuOhmB64R8rDyeKfeNbCs5oMvLV8Gn3FEA/uZdhSW4F20PWSRs5A?=
 =?us-ascii?Q?6+m1m4FRLWwydEH5LnrL1GR2xdJVCpFPgBBdDFW+nqOfa+PEFfXJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb15a4e-e5bc-48c2-1ed3-08deba2649a7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:34.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGHlswKmOQYzCHCG3B6xf16ZVSiRct70dXXfg1kmsUddRKkzxeeupEl6BA1VkxZ8ocJQYijlSpVF6NALh2L/eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4655
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10808-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 025855C65C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a dma_request_channel() filter that matches a DesignWare eDMA
write/read hardware channel by hardware channel number.

PCI endpoint resource enumeration can describe hardware channel metadata
and let consumers claim it through the normal DMAengine request path.
This avoids returning an unclaimed dma_chan pointer to the caller and does
not require making dma_get_slave_channel() public.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. Replace the raw channel lookup helper with a
    dma_request_channel() filter.
  - Do not make dma_get_slave_channel() public.
    Patch 01/12 "dmaengine: Make dma_get_slave_channel() public" is
    dropped.

 drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
 include/linux/dma/edma.h           | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c2feb3adc79f..80b4a168225b 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1189,6 +1189,21 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+bool dw_edma_filter_hw_chan(struct dma_chan *dchan, void *param)
+{
+	struct dw_edma_hw_chan_filter *filter = param;
+	struct dw_edma_chan *chan;
+
+	if (!filter || dchan->device->dev != filter->dma_dev)
+		return false;
+
+	chan = dchan2dw_edma_chan(dchan);
+
+	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
+	       chan->id == filter->id;
+}
+EXPORT_SYMBOL_GPL(dw_edma_filter_hw_chan);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1fafd5b0e315..3e15cf83b784 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -106,10 +106,23 @@ struct dw_edma_chip {
 	bool			cfg_non_ll;
 };
 
+/**
+ * struct dw_edma_hw_chan_filter - DesignWare eDMA hardware channel selector
+ * @dma_dev: DMA controller device to match
+ * @write: true to select a write channel, false to select a read channel
+ * @id: hardware channel number within the selected direction
+ */
+struct dw_edma_hw_chan_filter {
+	struct device	*dma_dev;
+	bool		write;
+	u16		id;
+};
+
 /* Export to the platform drivers */
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+bool dw_edma_filter_hw_chan(struct dma_chan *chan, void *param);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -120,6 +133,11 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline bool dw_edma_filter_hw_chan(struct dma_chan *chan, void *param)
+{
+	return false;
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0



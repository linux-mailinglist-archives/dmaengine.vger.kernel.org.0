Return-Path: <dmaengine+bounces-10822-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGehJrPuE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10822-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:39:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F15C69CC
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24293053EA4
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66EB3A874C;
	Mon, 25 May 2026 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Fk0IeGsL"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020124.outbound.protection.outlook.com [52.101.228.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81A3A7F46;
	Mon, 25 May 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690911; cv=fail; b=Gg8syVw+KsHIJSA7UiJILcA3u69Idl1zPX87VsFeKvImMgwjp9cPU6oYG0xOjCvy5em5l+2No28LaPpmN2LzklHeB1KvAairaVy5qAadGG1eQvEhNw4H0zLNjbb0Ofl2yNeyNAo77mtlW0evBWJtpSXCe6irF7L88Kkjis+DXKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690911; c=relaxed/simple;
	bh=Kms4vIPibI135piD4xBDIDesdBFUksnQrROTpxjzZlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uYGlmeSjZhfDLREMSivBfcW/6zehhgJuJhr7w1kkZ0lkXaDxOeZJ4Q0zoWzqFP0ytX1hV9RRDUJXCrrNU1JMVFGdGXSFBfeRKaZyj3U9HYEHzk+fklvs+09uyqi1tNbrjcfB/hEghrggo4Uqxv6HP3NJbgTnMGpwftYZLgu73As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Fk0IeGsL; arc=fail smtp.client-ip=52.101.228.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhyUkI5z9OyZzmIirBMKb3JcLz5pyIlBsudIIYx8Vqv8Kfji98P4jvYj44JHypru0Es14ADhjTYeXDOLEA7ozwa7MbyMi/U5wtVEzifna+3iwMlpBUuO3TTKKNwEc4L9vdlp7Vlnr57/U9DKcvEjttdxC8yYZhuz/rWDk5JgHLDYfghyYh0JHLSPGyflVkyLl1ONnceTDdpYGWF0974+zBsQAuG/opGEOraUgVq8h7bFeS/ViuCfuvV8HBl6y0ItyqpCDI/olyNoxtken8A/G3Ggd9uI+IFVsvDEQNURnlIMAp2tw++e6vX12A2orhNp7ABo9MupeviAv2RimImnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XkJPwg/xW4BNS73YfYriN98cwUYkCZZI11t04FF+KA=;
 b=Lq4jb/qZYtGjRG5GVUHKcH5GABsOfGuhlv6EOibv2inB+J+8eB7Ud3FvV/MIJ7sk4jGcan1CY2wMleixNm81EDFjrw5BCXEtkt+Iy13gXWNOkQT807OIeET0r5a9x25qTN6BOMpfB9l9KRhZzsY1Hro5ibK7bUqxWhtd9pbSbma/c4A/qn68+kZ7TPUxBcKScxtWdjJTtIwOiD7hRZmdoX++ZnR4QQ0HQoeqE/HQIR4iyuleutP4uoTp+7UW2Zi1gHDu3ST0PTGEQioUpiiFno/WsKuSLEedVNTPsHnbOLwYecLZzpvKc94yYN885+8Cp+djWcQGG9WLlv+hQu7VPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XkJPwg/xW4BNS73YfYriN98cwUYkCZZI11t04FF+KA=;
 b=Fk0IeGsL4G6NWPUeTPX2Q5OTrTiNHIFg7syx26hNGc43gMh7W2dMDY2TfcVROjlKLuBz1DLcRA22j2FkCWnDBCpCsMJ53hsAHSeoASd4P69kjHCTlNdjWN66Q/KuHaJcFWOm6/UYD0D+DwP0g8gts+oHyZt01+SgieYsORILT1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB2042.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:191::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:35:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:35:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: endpoint: Add DMA endpoint function
Date: Mon, 25 May 2026 15:34:55 +0900
Message-ID: <20260525063456.3317509-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525063456.3317509-1-den@valinux.co.jp>
References: <20260525063456.3317509-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 773bde4d-ef72-43f9-5182-08deba27bea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|5023799004|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V6toAkRr9AudGB6j6kjSlK4a9XuXKEs+J6zOwnMhTQDbzbmQsk1U3U6J6pOFeLNZ9IKrJ94+nkmNsvaJ9b3rc/mCMe0sTkpYDsxkA+N0n4UbwpapbHt/3zHRe0Q49KCo1LcpkcpQlYCABTh7Dja8QXga+oJfNhnQacmDfczZ5CxUP8KARE4dBVKE4WWDKh3p136aB1EWkp5OF+6KwvQSWBt+/GVdjLIq6oD6rSLwuGZ7najVB3+q74J+SQFaCH1H+Cd6zK1syD26hmL1zcZkd5P4jmSZk4tRJtA7T1VE7TRjUatrPS6B81vieO+OWBCTkqm5CNxbrcNq9jEyBWD2+34B/H4Z5Je1qT+FHW1JGPHf8qGPU1+qU3NM2Yz5JgX14lENihtL2lELI7CpHoEV32m7ZgC+orSJ8Qyo95urn7zStmFVtSEBmRUEUXq4j0yLYLkeofoNGgRV3eo4Bj8ccdvPS0CGA0URQBUXDDDaPfissC7VO8wfu4gLl/W1I9jWa8eiDX4zPkiQrU7TaCSsSa5XL25Vkyil2fx3ee8+gj6yyvxsxy4GR5jm0MWFIy5HWhbFMwEJID5HbYxY5SB7ko38PA/zmGWSdmnPB5X8+AbeJ/1cm+2C7cpna/FnQHbAlgt+c+LVfu75/fZjmizOUE/BCiZD249VqD9q7KcNWmv1/jSyvT64HGqZHFQNGab+Iz5EAkSv039DRf6+LHXRNHDFUg31FAdw7tRTmyC+nMY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(5023799004)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnVLR9O8aBfLElAot+Vm5KvPc705BLpbJ/o4Dw3EgAWM4zy/NUl1+/qmZpFJ?=
 =?us-ascii?Q?5XHAKZEoMBgT9xjCjtM0GxquOWSW8NKQvZeM6QdO7xD8MhImBrTouPC/ajNa?=
 =?us-ascii?Q?r5UwSImWTEN05DriT8685JDxySXgn972y8HYVkOZWTyq1yXAKNQZby+ALscQ?=
 =?us-ascii?Q?o9YOyFM2DD1CXBCoG9Udju05L8ftDszWLU34lQPWiea0Jui5SZM22e5+2vhd?=
 =?us-ascii?Q?v7AO0drJwSgrK3mdPZxgc7UREQ+gpWKTbOrsTS7PTdAXp/GuULIfAfN5oLdd?=
 =?us-ascii?Q?S8uva8twMvLs81kpkMUbd1mneydGd23FaRpZaR31aqI/ACmzdiXGWzI4tTNA?=
 =?us-ascii?Q?Q2ogvQTfJ9nBluMIzY8J+1xvkgi2S9Qp0icoe4EZ1fcirsVoVbToCZ+piovF?=
 =?us-ascii?Q?O2MN/fgdnuUWImqUinCoamv8YjkMWWpdR31X9pcs7eKWsIM0xghqr/hT8pRi?=
 =?us-ascii?Q?LDAd9eIEJj5NiKTGTIhKTVjmxERo0nBCKGOxMsbx5QqdTkgRyIA2QWTHpokB?=
 =?us-ascii?Q?jkY5t8VNpHbZE486F/AtzFLGSXCUdqntizi8Ab16lYMvIxEFqhgn0dm8gYvK?=
 =?us-ascii?Q?IRruUwUjKfrE/EN7T9fXdJv3X7JqCutXB/DdJbOnNOLjWws04wVSSX3aDGdJ?=
 =?us-ascii?Q?Up1t2jZBnZO8dQ8YXNmEeGKaIbcsHpbaZQllrjMp/G4/Yrc7wtT6yo1nm00S?=
 =?us-ascii?Q?QwqgEvAjmnx5FXDG+nP3NnDefAoVpvoH1AEpnekDNNgYuw2PfOv+Jg1r7dbc?=
 =?us-ascii?Q?p/0fDiT7VSCN+0X/QnaWszDnePBCN7H3ygz7mP81reeawM/YpC8mrMibkRAa?=
 =?us-ascii?Q?LSuBkOwA92EZWxeUbSaXgSND0vUQAIvcOdbmuoGw9oD/4KyHWd/tHOY758xD?=
 =?us-ascii?Q?YLQ2c1B4gTMu71J3xOkVRAAghgOnYQMs/LyIEov5fnOIj57NVTH3fAnbsMK0?=
 =?us-ascii?Q?SIxn/vqpHBkAepU4VoURAIN6P0QDLaOl3/zYVAVLMT+sjeNP5L/td7y+FrXY?=
 =?us-ascii?Q?aMA+oPZpJaZ5ByP9xgFJ9GZWBcMJmrhjJ+UPwkzGGmymGd99PIZShS0k/oO3?=
 =?us-ascii?Q?9uFwGV9dQZ3XiL5iYXHXKGBCrNgF3l4kGiz7tbDX6b84qNEaeeDwHDaCY29f?=
 =?us-ascii?Q?CNwXu9gPF8Yb0BY/p0DVl4I5+97ltp8yu6llzSxXoI/wjFDBVrXPKJR6Sg5t?=
 =?us-ascii?Q?y0Hv5BZKTNm0ZBt7Z7YjK/P85/uBfT+chsPsFD7rEdwKK7wvItF+TpH6YauY?=
 =?us-ascii?Q?dpJSZvu+UEumWv/wUh3myHqZOSaxgwocX/dVyqj3waVHN4lWTCWwLZjA+998?=
 =?us-ascii?Q?NAvmgWe06wUPFeGvi7lRWDZioMYk1UDB7maLOMnmZDaLqbyrM4slD1ULJUPG?=
 =?us-ascii?Q?CawmipY9SpXLvbwkpjsVU3Ly3ilMXSKyQpxkVMO0rHjtPURoMu48xh/oCC7v?=
 =?us-ascii?Q?L9WYomWXcSe0AcooMoiYnkA+OW+CyzFnXZTBM4+Bz0S3TC2qj9sNK2w3+yoP?=
 =?us-ascii?Q?DWhlyqm0hPaHkWYd9fMGGKVCqTwWXE4UzKQA87HzcKQnytJBuxeCf+85Oy+m?=
 =?us-ascii?Q?NXnjFh4CWC119gAtzZ5Q9yR8wNgG0Dkz3tsb1HIi3UfD4eDEQg3hfMZ8Wf6y?=
 =?us-ascii?Q?yjGhhFXRZyCk59i8XmAHYlJoK3JJBEyPt54j+jHUrBFDWRj3RJcmB8Any8Uf?=
 =?us-ascii?Q?b9U4oJ8JaVwO0YQtzYTgVqyO8DqaShlIdKWTKTltIH+hw98e6UtP6ybmGe7l?=
 =?us-ascii?Q?tRTpB8E0iSVo+LEfVSRz8lg1AIKwObSLhsuPu9lT8SsoypIJ8Vy/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 773bde4d-ef72-43f9-5182-08deba27bea8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:34:59.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqEc04uqexcnkpsaKN86tFkCTWyzYNiWZH5QC7T+FZsGGwO4s5rRSOOzlrTU3T/0VKPfIuXPMqYSKr+SuCgxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2042
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10822-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: CC1F15C69CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add pci-epf-dma, an endpoint function that exposes selected
endpoint-integrated DMA channels as a separate PCI DMA controller
function.

The function consumes EPC auxiliary DMA resources, publishes a stable
metadata BAR for host discovery, and uses a DMA window BAR for DMA
resources that are not already host-visible. After the host-side driver
finds the metadata and requests the final layout, the endpoint function
programs DMA window BAR submaps and marks the metadata ready.

The endpoint function does not bake in a vendor/device ID. As with other
generic endpoint functions, users provide the PCI IDs through the common
EPF configfs header attributes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Claim delegated channels through standard dma_filter_fn obtained
    from EPC auxiliary resources query, instead of using raw DMA channel
    pointers.

 drivers/pci/endpoint/functions/Kconfig       |   14 +
 drivers/pci/endpoint/functions/Makefile      |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c | 1366 ++++++++++++++++++
 3 files changed, 1381 insertions(+)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
index bb5a23994288..078ac19dc772 100644
--- a/drivers/pci/endpoint/functions/Kconfig
+++ b/drivers/pci/endpoint/functions/Kconfig
@@ -39,6 +39,20 @@ config PCI_EPF_VNTB
 
 	  If in doubt, say "N" to disable Endpoint NTB driver.
 
+config PCI_EPF_DMA
+	tristate "PCI Endpoint DMA driver"
+	depends on PCI_ENDPOINT
+	select CONFIGFS_FS
+	select DMA_ENGINE
+	help
+	  Select this configuration option to expose an endpoint-integrated
+	  DMA controller as a PCI endpoint function. The function advertises
+	  the DMA controller layout to the host using BAR-resident metadata
+	  and maps resources that are not already host-visible into the
+	  DMA window BAR.
+
+	  If in doubt, say "N" to disable Endpoint DMA driver.
+
 config PCI_EPF_MHI
 	tristate "PCI Endpoint driver for MHI bus"
 	depends on PCI_ENDPOINT && MHI_BUS_EP
diff --git a/drivers/pci/endpoint/functions/Makefile b/drivers/pci/endpoint/functions/Makefile
index 696473fce50e..de92f6897b8f 100644
--- a/drivers/pci/endpoint/functions/Makefile
+++ b/drivers/pci/endpoint/functions/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_PCI_EPF_TEST)		+= pci-epf-test.o
 obj-$(CONFIG_PCI_EPF_NTB)		+= pci-epf-ntb.o
 obj-$(CONFIG_PCI_EPF_VNTB) 		+= pci-epf-vntb.o
+obj-$(CONFIG_PCI_EPF_DMA)		+= pci-epf-dma.o
 obj-$(CONFIG_PCI_EPF_MHI)		+= pci-epf-mhi.o
diff --git a/drivers/pci/endpoint/functions/pci-epf-dma.c b/drivers/pci/endpoint/functions/pci-epf-dma.c
new file mode 100644
index 000000000000..27f1a8b1acd5
--- /dev/null
+++ b/drivers/pci/endpoint/functions/pci-epf-dma.c
@@ -0,0 +1,1366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI endpoint function that exposes an endpoint-integrated DMA controller
+ * to the PCI host.
+ *
+ * The host-side dw-edma-pcie driver consumes the BAR metadata published
+ * by this function.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/configfs.h>
+#include <linux/dma/edma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci_regs.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+/* HOST_REQ is set by the host driver, so poll it at a low idle rate. */
+#define PCI_EPF_DMA_HOST_REQ_POLL_MS	500
+
+struct pci_epf_dma_bar_map {
+	const struct pci_epc_aux_resource *res;
+	enum pci_barno bar;
+	u64 res_offset_in_bar;
+	u64 submap_offset_in_bar;
+	dma_addr_t phys_addr;
+	size_t map_size;
+	bool needs_submap;
+};
+
+struct pci_epf_dma {
+	struct pci_epf *epf;
+	struct config_group group;
+	struct delayed_work map_work;
+
+	enum pci_barno metadata_bar;
+	enum pci_barno dma_window_bar;
+	u16 wr_chans;
+	u16 rd_chans;
+	u8 reg_layout;
+	u8 reg_layout_data;
+
+	/* Backing storage for ctrl and descriptor resource pointers. */
+	struct pci_epc_aux_resource *resources;
+	unsigned int num_resources;
+	const struct pci_epc_aux_resource *ctrl;
+	const struct pci_epc_aux_resource *ep_to_rc_desc[EDMA_MAX_WR_CH];
+	const struct pci_epc_aux_resource *rc_to_ep_desc[EDMA_MAX_RD_CH];
+
+	/* Local DMAengine reservations for channels delegated to the host. */
+	struct dma_chan *ep_to_rc_chan[EDMA_MAX_WR_CH];
+	struct dma_chan *rc_to_ep_chan[EDMA_MAX_RD_CH];
+
+	void *metadata_addr;
+	void *dma_window_addr;
+	size_t msix_table_offset;
+	struct pci_epf_dma_bar_map *bar_maps;
+	unsigned int num_bar_maps;
+	struct pci_epf_bar_submap *submaps;
+	unsigned int num_submaps;
+
+	/* Cleared when a later event should retry programming the submaps. */
+	bool submaps_programmed;
+};
+
+#define to_epf_dma(epf_group) container_of((epf_group), struct pci_epf_dma, group)
+
+static struct pci_epf_header pci_epf_dma_header = {
+	.vendorid	= PCI_ANY_ID,
+	.deviceid	= PCI_ANY_ID,
+	.baseclass_code	= PCI_BASE_CLASS_SYSTEM,
+	.subclass_code	= PCI_CLASS_SYSTEM_DMA & 0xff,
+	.interrupt_pin	= PCI_INTERRUPT_INTA,
+};
+
+static void pci_epf_dma_release_channels(struct pci_epf_dma *epf_dma)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(epf_dma->ep_to_rc_chan); i++) {
+		if (!epf_dma->ep_to_rc_chan[i])
+			continue;
+
+		dma_release_channel(epf_dma->ep_to_rc_chan[i]);
+		epf_dma->ep_to_rc_chan[i] = NULL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(epf_dma->rc_to_ep_chan); i++) {
+		if (!epf_dma->rc_to_ep_chan[i])
+			continue;
+
+		dma_release_channel(epf_dma->rc_to_ep_chan[i]);
+		epf_dma->rc_to_ep_chan[i] = NULL;
+	}
+}
+
+static int pci_epf_dma_claim_channel(struct pci_epf_dma *epf_dma,
+				     const struct pci_epc_aux_resource *res,
+				     struct dma_chan **chan)
+{
+	struct device *dev = &epf_dma->epf->dev;
+	struct dma_chan *dma_chan;
+	dma_cap_mask_t mask;
+
+	if (!res->u.dma_desc.dma_dev || !res->u.dma_desc.filter_fn) {
+		dev_err(dev, "DMA channel %u cannot be reserved\n",
+			res->u.dma_desc.hw_ch);
+		return -EOPNOTSUPP;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dma_chan = dma_request_channel(mask, res->u.dma_desc.filter_fn,
+				       (void *)res);
+	if (!dma_chan) {
+		dev_err(dev, "DMA channel %u is not available\n",
+			res->u.dma_desc.hw_ch);
+		return -EBUSY;
+	}
+
+	*chan = dma_chan;
+
+	return 0;
+}
+
+static int
+pci_epf_dma_validate_dw_edma_ctrl(struct pci_epf_dma *epf_dma,
+				  const struct pci_epc_aux_resource *ctrl)
+{
+	struct device *dev = &epf_dma->epf->dev;
+	enum dw_edma_map_format map = ctrl->u.dma_ctrl.reg_layout_data;
+	u16 total_wr_chans = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt;
+	u16 total_rd_chans = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	switch (map) {
+	case EDMA_MF_EDMA_LEGACY:
+		dev_err(dev, "legacy DesignWare eDMA layout cannot be delegated\n");
+		return -EOPNOTSUPP;
+	case EDMA_MF_EDMA_UNROLL:
+	case EDMA_MF_HDMA_COMPAT:
+		if ((epf_dma->wr_chans && epf_dma->wr_chans != total_wr_chans) ||
+		    (epf_dma->rd_chans && epf_dma->rd_chans != total_rd_chans)) {
+			dev_err(dev, "DesignWare eDMA v0 delegation must cover the whole direction\n");
+			return -EOPNOTSUPP;
+		}
+		return 0;
+	case EDMA_MF_HDMA_NATIVE:
+		dev_err(dev, "DesignWare HDMA native layout cannot be delegated\n");
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool pci_epf_dma_bar_usable(const struct pci_epc_features *epc_features,
+				   enum pci_barno bar)
+{
+	if (bar < BAR_0 || bar >= PCI_STD_NUM_BARS)
+		return false;
+
+	return epc_features->bar[bar].type != BAR_RESERVED &&
+	       epc_features->bar[bar].type != BAR_DISABLED;
+}
+
+static bool pci_epf_dma_bar_has_fixed_resource(struct pci_epf_dma *epf_dma,
+					       enum pci_barno bar)
+{
+	unsigned int i;
+
+	for (i = 0; i < epf_dma->num_resources; i++) {
+		if (epf_dma->resources[i].bar == bar)
+			return true;
+	}
+
+	return false;
+}
+
+static enum pci_barno
+pci_epf_dma_first_usable_bar(struct pci_epf_dma *epf_dma,
+			     const struct pci_epc_features *epc_features,
+			     enum pci_barno exclude)
+{
+	enum pci_barno bar;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		bar = pci_epc_get_next_free_bar(epc_features, bar);
+		if (bar == NO_BAR)
+			return NO_BAR;
+		if (bar != exclude &&
+		    !pci_epf_dma_bar_has_fixed_resource(epf_dma, bar))
+			return bar;
+	}
+
+	return NO_BAR;
+}
+
+static size_t pci_epf_dma_align_size(size_t size, size_t align)
+{
+	if (!align)
+		return size;
+
+	return ALIGN(size, align);
+}
+
+static int pci_epf_dma_reuse_submap(struct pci_epf_dma *epf_dma,
+				    unsigned int map_count,
+				    dma_addr_t phys_addr, size_t map_size,
+				    size_t offset, size_t *next_offset_in_bar,
+				    u64 *res_offset_in_bar)
+{
+	struct pci_epf_dma_bar_map *map;
+	u64 delta;
+	size_t merged_size, next;
+	u64 res_map_end, submap_bar_end, submap_phys_end;
+	unsigned int i;
+
+	if (check_add_overflow(phys_addr, map_size, &res_map_end))
+		return -EOVERFLOW;
+
+	for (i = 0; i < map_count; i++) {
+		map = &epf_dma->bar_maps[i];
+		if (!map->needs_submap || map->bar != epf_dma->dma_window_bar)
+			continue;
+
+		if (check_add_overflow(map->phys_addr, map->map_size,
+				       &submap_phys_end) ||
+		    check_add_overflow(map->submap_offset_in_bar,
+				       map->map_size, &submap_bar_end))
+			return -EOVERFLOW;
+
+		/*
+		 * Reuse a submap that already covers this aligned resource
+		 * window.
+		 */
+		if (phys_addr >= map->phys_addr &&
+		    res_map_end <= submap_phys_end) {
+			if (check_add_overflow(phys_addr - map->phys_addr,
+					       offset, &delta) ||
+			    check_add_overflow(map->submap_offset_in_bar,
+					       delta, res_offset_in_bar))
+				return -EOVERFLOW;
+			return 1;
+		}
+
+		/*
+		 * Extend only the BAR-tail submap when the physical ranges are
+		 * contiguous.
+		 */
+		if (submap_phys_end == phys_addr &&
+		    submap_bar_end == *next_offset_in_bar) {
+			if (check_add_overflow(map->map_size, map_size,
+					       &merged_size) ||
+			    check_add_overflow(*next_offset_in_bar, map_size,
+					       &next) ||
+			    check_add_overflow(*next_offset_in_bar, offset,
+					       res_offset_in_bar))
+				return -EOVERFLOW;
+
+			map->map_size = merged_size;
+			*next_offset_in_bar = next;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int pci_epf_dma_add_map(struct pci_epf_dma *epf_dma,
+			       const struct pci_epc_aux_resource *res,
+			       size_t align, size_t *next_offset_in_bar,
+			       unsigned int *map_idx)
+{
+	dma_addr_t phys_addr;
+	size_t map_size, offset = 0, next;
+	u64 res_offset_in_bar;
+	int ret;
+
+	if (!res || !res->size)
+		return -EINVAL;
+
+	if (res->bar != NO_BAR) {
+		if (res->bar < BAR_0 || res->bar >= PCI_STD_NUM_BARS)
+			return -EINVAL;
+		if (res->bar == epf_dma->metadata_bar ||
+		    res->bar == epf_dma->dma_window_bar)
+			return -EINVAL;
+
+		epf_dma->bar_maps[*map_idx] = (struct pci_epf_dma_bar_map) {
+			.res = res,
+			.bar = res->bar,
+			.res_offset_in_bar = res->bar_offset,
+			.map_size = res->size,
+		};
+		(*map_idx)++;
+
+		return 0;
+	}
+
+	if (epf_dma->dma_window_bar == NO_BAR)
+		return -EOPNOTSUPP;
+
+	phys_addr = res->phys_addr;
+	/* Map the aligned window that contains this resource. */
+	if (align) {
+		phys_addr = ALIGN_DOWN(res->phys_addr, align);
+		offset = res->phys_addr - phys_addr;
+	}
+
+	if (check_add_overflow(res->size, offset, &map_size))
+		return -EOVERFLOW;
+	map_size = pci_epf_dma_align_size(map_size, align);
+
+	ret = pci_epf_dma_reuse_submap(epf_dma, *map_idx, phys_addr, map_size,
+				       offset, next_offset_in_bar,
+				       &res_offset_in_bar);
+	if (ret < 0)
+		return ret;
+	if (ret) {
+		epf_dma->bar_maps[*map_idx] = (struct pci_epf_dma_bar_map) {
+			.res = res,
+			.bar = epf_dma->dma_window_bar,
+			.res_offset_in_bar = res_offset_in_bar,
+			.phys_addr = res->phys_addr,
+			.map_size = res->size,
+		};
+
+		(*map_idx)++;
+
+		return 0;
+	}
+
+	if (check_add_overflow(*next_offset_in_bar, map_size, &next))
+		return -EOVERFLOW;
+	if (check_add_overflow(*next_offset_in_bar, offset, &res_offset_in_bar))
+		return -EOVERFLOW;
+
+	epf_dma->bar_maps[*map_idx] = (struct pci_epf_dma_bar_map) {
+		.res = res,
+		.bar = epf_dma->dma_window_bar,
+		.res_offset_in_bar = res_offset_in_bar,
+		.submap_offset_in_bar = *next_offset_in_bar,
+		.phys_addr = phys_addr,
+		.map_size = map_size,
+		.needs_submap = true,
+	};
+
+	*next_offset_in_bar = next;
+	(*map_idx)++;
+
+	return 0;
+}
+
+static const struct pci_epf_dma_bar_map *
+pci_epf_dma_find_map(struct pci_epf_dma *epf_dma,
+		     const struct pci_epc_aux_resource *res)
+{
+	unsigned int i;
+
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		if (epf_dma->bar_maps[i].res == res)
+			return &epf_dma->bar_maps[i];
+	}
+
+	return NULL;
+}
+
+static bool pci_epf_dma_needs_dma_window(struct pci_epf_dma *epf_dma)
+{
+	unsigned int i;
+
+	if (epf_dma->ctrl && epf_dma->ctrl->bar == NO_BAR)
+		return true;
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		if (epf_dma->ep_to_rc_desc[i] &&
+		    epf_dma->ep_to_rc_desc[i]->bar == NO_BAR)
+			return true;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		if (epf_dma->rc_to_ep_desc[i] &&
+		    epf_dma->rc_to_ep_desc[i]->bar == NO_BAR)
+			return true;
+	}
+
+	return false;
+}
+
+static int pci_epf_dma_collect_resources(struct pci_epf_dma *epf_dma)
+{
+	const struct pci_epc_aux_resource *ep_to_rc_desc[EDMA_MAX_WR_CH] = {};
+	const struct pci_epc_aux_resource *rc_to_ep_desc[EDMA_MAX_RD_CH] = {};
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	struct pci_epf *epf = epf_dma->epf;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int count, i, ret;
+
+	count = pci_epc_get_aux_resources_count(epc, epf->func_no,
+						epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+						kzalloc_objs(*res, count);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		switch (res[i].type) {
+		case PCI_EPC_AUX_DMA_CTRL_MMIO:
+			if (ctrl)
+				return -EINVAL;
+			ctrl = &res[i];
+			break;
+		case PCI_EPC_AUX_DMA_DESC_MEM: {
+			u16 hw_ch = res[i].u.dma_desc.hw_ch;
+
+			switch (res[i].u.dma_desc.dir) {
+			case PCI_EPC_AUX_DMA_EP_TO_RC:
+				if (hw_ch >= EDMA_MAX_WR_CH ||
+				    ep_to_rc_desc[hw_ch])
+					return -EINVAL;
+				ep_to_rc_desc[hw_ch] = &res[i];
+				break;
+			case PCI_EPC_AUX_DMA_RC_TO_EP:
+				if (hw_ch >= EDMA_MAX_RD_CH ||
+				    rc_to_ep_desc[hw_ch])
+					return -EINVAL;
+				rc_to_ep_desc[hw_ch] = &res[i];
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		}
+		default:
+			continue;
+		}
+	}
+
+	if (!ctrl)
+		return -ENODEV;
+
+	if (!epf_dma->wr_chans && !epf_dma->rd_chans)
+		return -EINVAL;
+
+	if (epf_dma->wr_chans > ctrl->u.dma_ctrl.ep_to_rc_ch_cnt ||
+	    epf_dma->rd_chans > ctrl->u.dma_ctrl.rc_to_ep_ch_cnt)
+		return -EINVAL;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		ret = pci_epf_dma_validate_dw_edma_ctrl(epf_dma, ctrl);
+		if (ret)
+			return ret;
+		epf_dma->reg_layout = PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA;
+		epf_dma->reg_layout_data = ctrl->u.dma_ctrl.reg_layout_data;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		if (!ep_to_rc_desc[i]) {
+			dev_err(dev, "missing dense write DMA channel %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		if (!rc_to_ep_desc[i]) {
+			dev_err(dev, "missing dense read DMA channel %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		ret = pci_epf_dma_claim_channel(epf_dma, ep_to_rc_desc[i],
+						&epf_dma->ep_to_rc_chan[i]);
+		if (ret)
+			goto err_release_channels;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		ret = pci_epf_dma_claim_channel(epf_dma, rc_to_ep_desc[i],
+						&epf_dma->rc_to_ep_chan[i]);
+		if (ret)
+			goto err_release_channels;
+	}
+
+	epf_dma->resources = no_free_ptr(res);
+	epf_dma->num_resources = count;
+	epf_dma->ctrl = ctrl;
+	memcpy(epf_dma->ep_to_rc_desc, ep_to_rc_desc, sizeof(ep_to_rc_desc));
+	memcpy(epf_dma->rc_to_ep_desc, rc_to_ep_desc, sizeof(rc_to_ep_desc));
+
+	return 0;
+
+err_release_channels:
+	pci_epf_dma_release_channels(epf_dma);
+
+	return ret;
+}
+
+static void pci_epf_dma_metadata_write(__le32 *metadata, u16 metadata_off,
+				       u32 val)
+{
+	metadata[metadata_off / sizeof(*metadata)] = cpu_to_le32(val);
+}
+
+static void pci_epf_dma_metadata_write64(__le32 *metadata, u16 metadata_off,
+					 u64 val)
+{
+	pci_epf_dma_metadata_write(metadata, metadata_off, lower_32_bits(val));
+	pci_epf_dma_metadata_write(metadata, metadata_off + sizeof(u32),
+				   upper_32_bits(val));
+}
+
+static int pci_epf_dma_build_ch_entry(const struct pci_epf_dma_bar_map *map,
+				      __le32 *metadata, u16 entry)
+{
+	const struct pci_epc_aux_resource *res = map->res;
+	u32 ctrl;
+
+	if (res->size > U32_MAX)
+		return -EOVERFLOW;
+
+	ctrl = FIELD_PREP(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH,
+			  res->u.dma_desc.hw_ch) |
+	       FIELD_PREP(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, map->bar);
+
+	pci_epf_dma_metadata_write(metadata, entry + PCI_EP_DMA_METADATA_CH_CTRL,
+				   ctrl);
+	pci_epf_dma_metadata_write64(metadata,
+				     entry + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO,
+				     map->res_offset_in_bar);
+	pci_epf_dma_metadata_write(metadata,
+				   entry + PCI_EP_DMA_METADATA_CH_DESC_SIZE,
+				   (u32)res->size);
+	pci_epf_dma_metadata_write64(metadata,
+				     entry + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO,
+				     res->phys_addr);
+
+	return 0;
+}
+
+static void pci_epf_dma_set_metadata_ready(struct pci_epf_dma *epf_dma,
+					   bool ready)
+{
+	__le32 *metadata = epf_dma->metadata_addr;
+	__le32 *ctrl_ptr;
+	u32 ctrl;
+
+	if (!metadata)
+		return;
+
+	ctrl_ptr = &metadata[PCI_EP_DMA_METADATA_CTRL / sizeof(*metadata)];
+	ctrl = le32_to_cpu(READ_ONCE(*ctrl_ptr));
+	if (ready) {
+		dma_wmb();
+		ctrl |= PCI_EP_DMA_METADATA_CTRL_READY;
+	} else {
+		ctrl &= ~PCI_EP_DMA_METADATA_CTRL_READY;
+	}
+	WRITE_ONCE(*ctrl_ptr, cpu_to_le32(ctrl));
+}
+
+static bool pci_epf_dma_metadata_host_requested(struct pci_epf_dma *epf_dma)
+{
+	__le32 *metadata = epf_dma->metadata_addr;
+	u32 ctrl;
+
+	if (!metadata)
+		return false;
+
+	ctrl = le32_to_cpu(READ_ONCE(metadata[PCI_EP_DMA_METADATA_CTRL /
+					    sizeof(*metadata)]));
+
+	return ctrl & PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+}
+
+static void pci_epf_dma_clear_metadata_status(struct pci_epf_dma *epf_dma)
+{
+	__le32 *metadata = epf_dma->metadata_addr;
+	__le32 *ctrl_ptr;
+	u32 ctrl;
+
+	if (!metadata)
+		return;
+
+	ctrl_ptr = &metadata[PCI_EP_DMA_METADATA_CTRL / sizeof(*metadata)];
+	ctrl = le32_to_cpu(READ_ONCE(*ctrl_ptr));
+	ctrl &= ~(PCI_EP_DMA_METADATA_CTRL_HOST_REQ |
+		  PCI_EP_DMA_METADATA_CTRL_READY);
+	WRITE_ONCE(*ctrl_ptr, cpu_to_le32(ctrl));
+}
+
+static int pci_epf_dma_build_metadata(struct pci_epf_dma *epf_dma)
+{
+	const struct pci_epf_dma_bar_map *ctrl_map;
+	u16 entry_size = PCI_EP_DMA_METADATA_CH_ENTRY_SIZE;
+	u16 wr_table, rd_table, total_len;
+	__le32 *metadata = epf_dma->metadata_addr;
+	unsigned int i;
+	int ret;
+
+	if (!metadata)
+		return -EINVAL;
+
+	ctrl_map = pci_epf_dma_find_map(epf_dma, epf_dma->ctrl);
+	if (!ctrl_map)
+		return -EINVAL;
+	if (epf_dma->wr_chans > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT) ||
+	    epf_dma->rd_chans > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT) ||
+	    entry_size > FIELD_MAX(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE) ||
+	    ctrl_map->res->size > U32_MAX)
+		return -EOVERFLOW;
+
+	wr_table = epf_dma->wr_chans ? PCI_EP_DMA_METADATA_HDR_LEN : 0;
+	rd_table = epf_dma->rd_chans ?
+		   PCI_EP_DMA_METADATA_HDR_LEN + epf_dma->wr_chans * entry_size : 0;
+	total_len = PCI_EP_DMA_METADATA_HDR_LEN +
+		    (epf_dma->wr_chans + epf_dma->rd_chans) * entry_size;
+
+	memset(metadata, 0, total_len);
+
+	pci_epf_dma_metadata_write(metadata, 0, PCI_EP_DMA_METADATA_MAGIC);
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_HDR,
+				   FIELD_PREP(PCI_EP_DMA_METADATA_HDR_REV,
+					      PCI_EP_DMA_METADATA_REV) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_HDR_LEN_FIELD,
+					      total_len));
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_CTRL,
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_REG_BAR,
+					      ctrl_map->bar) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT,
+					      epf_dma->wr_chans) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT,
+					      epf_dma->rd_chans) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE,
+					      entry_size));
+	pci_epf_dma_metadata_write64(metadata,
+				     PCI_EP_DMA_METADATA_REG_OFF_LO,
+				     ctrl_map->res_offset_in_bar);
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_REG_LAYOUT,
+				   FIELD_PREP(PCI_EP_DMA_METADATA_REG_LAYOUT_ID,
+					      epf_dma->reg_layout) |
+				   FIELD_PREP(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA,
+					      epf_dma->reg_layout_data));
+	pci_epf_dma_metadata_write(metadata, PCI_EP_DMA_METADATA_REG_SIZE,
+				   (u32)ctrl_map->res->size);
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		const struct pci_epf_dma_bar_map *map;
+
+		map = pci_epf_dma_find_map(epf_dma,
+					   epf_dma->ep_to_rc_desc[i]);
+		if (!map)
+			return -EINVAL;
+		ret = pci_epf_dma_build_ch_entry(map, metadata,
+						 wr_table + i * entry_size);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		const struct pci_epf_dma_bar_map *map;
+
+		map = pci_epf_dma_find_map(epf_dma,
+					   epf_dma->rc_to_ep_desc[i]);
+		if (!map)
+			return -EINVAL;
+		ret = pci_epf_dma_build_ch_entry(map, metadata,
+						 rd_table + i * entry_size);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int pci_epf_dma_reserve_msix(struct pci_epf_dma *epf_dma,
+				    const struct pci_epc_features *epc_features,
+				    size_t *backing_size)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	size_t msix_table_size, pba_size, next;
+	unsigned int nvec = epf->msix_interrupts;
+
+	epf_dma->msix_table_offset = 0;
+
+	if (!epc_features->msix_capable || !nvec)
+		return 0;
+
+	next = ALIGN(*backing_size, 8);
+	if (next > U32_MAX)
+		return -EOVERFLOW;
+	epf_dma->msix_table_offset = next;
+
+	if (check_mul_overflow(PCI_MSIX_ENTRY_SIZE, nvec, &msix_table_size))
+		return -EOVERFLOW;
+
+	pba_size = ALIGN(DIV_ROUND_UP(nvec, 8), 8);
+	if (check_add_overflow(next, msix_table_size, &next) ||
+	    next > U32_MAX ||
+	    check_add_overflow(next, pba_size, &next))
+		return -EOVERFLOW;
+
+	*backing_size = next;
+
+	return 0;
+}
+
+static int pci_epf_dma_build_layout(struct pci_epf_dma *epf_dma,
+				    const struct pci_epc_features *epc_features)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct device *dev = &epf->dev;
+	struct pci_epf_bar *bar;
+	unsigned int max_maps, map_idx = 0, sub_idx = 0;
+	size_t align = epc_features->align;
+	size_t metadata_size, metadata_backing_size, metadata_bar_size;
+	size_t mapped_size = 0, dma_window_bar_size;
+	int i, ret;
+
+	metadata_size = PCI_EP_DMA_METADATA_HDR_LEN;
+	metadata_size += (epf_dma->wr_chans + epf_dma->rd_chans) *
+			 PCI_EP_DMA_METADATA_CH_ENTRY_SIZE;
+	metadata_backing_size = metadata_size;
+	ret = pci_epf_dma_reserve_msix(epf_dma, epc_features,
+				       &metadata_backing_size);
+	if (ret)
+		return ret;
+	metadata_bar_size = pci_epf_dma_align_size(metadata_backing_size,
+						   align);
+
+	epf_dma->metadata_addr = pci_epf_alloc_space(epf, metadata_bar_size,
+						     epf_dma->metadata_bar,
+						     epc_features,
+						     PRIMARY_INTERFACE);
+	if (!epf_dma->metadata_addr) {
+		dev_err(dev, "failed to allocate BAR%d metadata space\n",
+			epf_dma->metadata_bar);
+		return -ENOMEM;
+	}
+	memset(epf_dma->metadata_addr, 0, epf->bar[epf_dma->metadata_bar].size);
+
+	/* One map for DMA controller registers, plus one per channel. */
+	max_maps = 1 + epf_dma->wr_chans + epf_dma->rd_chans;
+	epf_dma->bar_maps = kzalloc_objs(*epf_dma->bar_maps, max_maps);
+	if (!epf_dma->bar_maps)
+		return -ENOMEM;
+
+	ret = pci_epf_dma_add_map(epf_dma, epf_dma->ctrl, align,
+				  &mapped_size, &map_idx);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < epf_dma->wr_chans; i++) {
+		ret = pci_epf_dma_add_map(epf_dma,
+					  epf_dma->ep_to_rc_desc[i], align,
+					  &mapped_size, &map_idx);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < epf_dma->rd_chans; i++) {
+		ret = pci_epf_dma_add_map(epf_dma,
+					  epf_dma->rc_to_ep_desc[i], align,
+					  &mapped_size, &map_idx);
+		if (ret)
+			return ret;
+	}
+
+	epf_dma->num_bar_maps = map_idx;
+
+	ret = pci_epf_dma_build_metadata(epf_dma);
+	if (ret)
+		return ret;
+
+	/* Some DMA resources may already be visible through another map. */
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		if (epf_dma->bar_maps[i].needs_submap)
+			epf_dma->num_submaps++;
+	}
+	if (!epf_dma->num_submaps)
+		return 0;
+
+	dma_window_bar_size = mapped_size;
+	epf_dma->dma_window_addr =
+		pci_epf_alloc_space(epf, dma_window_bar_size,
+				    epf_dma->dma_window_bar, epc_features,
+				    PRIMARY_INTERFACE);
+	if (!epf_dma->dma_window_addr) {
+		dev_err(dev, "failed to allocate BAR%d DMA window space\n",
+			epf_dma->dma_window_bar);
+		return -ENOMEM;
+	}
+	bar = &epf->bar[epf_dma->dma_window_bar];
+	memset(epf_dma->dma_window_addr, 0, bar->size);
+
+	if (bar->size > mapped_size)
+		epf_dma->num_submaps++;
+
+	epf_dma->submaps = kzalloc_objs(*epf_dma->submaps, epf_dma->num_submaps);
+	if (!epf_dma->submaps)
+		return -ENOMEM;
+
+	for (i = 0; i < epf_dma->num_bar_maps; i++) {
+		if (!epf_dma->bar_maps[i].needs_submap)
+			continue;
+
+		epf_dma->submaps[sub_idx++] = (struct pci_epf_bar_submap) {
+			.phys_addr = epf_dma->bar_maps[i].phys_addr,
+			.size = epf_dma->bar_maps[i].map_size,
+		};
+	}
+
+	/* Cover any BAR tail padding with the allocated scratch space. */
+	if (bar->size > mapped_size) {
+		epf_dma->submaps[sub_idx++] = (struct pci_epf_bar_submap) {
+			.phys_addr = bar->phys_addr + mapped_size,
+			.size = bar->size - mapped_size,
+		};
+	}
+
+	return 0;
+}
+
+static void pci_epf_dma_free_layout(struct pci_epf_dma *epf_dma)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct pci_epf_bar *bar;
+
+	if (epf_dma->dma_window_addr) {
+		bar = &epf->bar[epf_dma->dma_window_bar];
+		bar->submap = NULL;
+		bar->num_submap = 0;
+	}
+	epf_dma->submaps_programmed = false;
+
+	kfree(epf_dma->submaps);
+	epf_dma->submaps = NULL;
+	epf_dma->num_submaps = 0;
+
+	kfree(epf_dma->bar_maps);
+	epf_dma->bar_maps = NULL;
+	epf_dma->num_bar_maps = 0;
+
+	pci_epf_dma_release_channels(epf_dma);
+
+	kfree(epf_dma->resources);
+	epf_dma->resources = NULL;
+	epf_dma->num_resources = 0;
+	epf_dma->ctrl = NULL;
+	memset(epf_dma->ep_to_rc_desc, 0, sizeof(epf_dma->ep_to_rc_desc));
+	memset(epf_dma->rc_to_ep_desc, 0, sizeof(epf_dma->rc_to_ep_desc));
+
+	if (epf_dma->dma_window_addr) {
+		pci_epf_free_space(epf, epf_dma->dma_window_addr,
+				   epf_dma->dma_window_bar,
+				   PRIMARY_INTERFACE);
+		epf_dma->dma_window_addr = NULL;
+	}
+
+	if (epf_dma->metadata_addr) {
+		pci_epf_free_space(epf, epf_dma->metadata_addr,
+				   epf_dma->metadata_bar,
+				   PRIMARY_INTERFACE);
+		epf_dma->metadata_addr = NULL;
+	}
+	epf_dma->msix_table_offset = 0;
+}
+
+static int pci_epf_dma_program_submaps(struct pci_epf_dma *epf_dma)
+{
+	struct pci_epf *epf = epf_dma->epf;
+	struct pci_epf_bar *bar;
+	int ret;
+
+	if (!epf_dma->dma_window_addr) {
+		pci_epf_dma_set_metadata_ready(epf_dma, true);
+		return 0;
+	}
+
+	if (epf_dma->submaps_programmed)
+		return 0;
+
+	bar = &epf->bar[epf_dma->dma_window_bar];
+	bar->submap = epf_dma->submaps;
+	bar->num_submap = epf_dma->num_submaps;
+
+	ret = pci_epc_set_bar(epf->epc, epf->func_no, epf->vfunc_no, bar);
+	if (ret) {
+		bar->submap = NULL;
+		bar->num_submap = 0;
+		return ret;
+	}
+
+	epf_dma->submaps_programmed = true;
+	pci_epf_dma_set_metadata_ready(epf_dma, true);
+
+	return 0;
+}
+
+static void pci_epf_dma_map_work(struct work_struct *work)
+{
+	struct pci_epf_dma *epf_dma =
+		container_of(to_delayed_work(work), struct pci_epf_dma,
+			     map_work);
+	struct pci_epf *epf = epf_dma->epf;
+	int ret;
+
+	if (!epf->epc)
+		return;
+
+	if (!epf->epc->init_complete) {
+		schedule_delayed_work(&epf_dma->map_work,
+				      msecs_to_jiffies(PCI_EPF_DMA_HOST_REQ_POLL_MS));
+		return;
+	}
+
+	if (!pci_epf_dma_metadata_host_requested(epf_dma)) {
+		schedule_delayed_work(&epf_dma->map_work,
+				      msecs_to_jiffies(PCI_EPF_DMA_HOST_REQ_POLL_MS));
+		return;
+	}
+
+	ret = pci_epf_dma_program_submaps(epf_dma);
+	if (ret)
+		dev_err(&epf->dev, "failed to program DMA window BAR submaps: %d\n",
+			ret);
+}
+
+static int pci_epf_dma_epc_init(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int ret;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features)
+		return -EOPNOTSUPP;
+
+	pci_epf_dma_clear_metadata_status(epf_dma);
+
+	ret = pci_epc_write_header(epc, epf->func_no, epf->vfunc_no,
+				   epf->header);
+	if (ret) {
+		dev_err(dev, "configuration header write failed\n");
+		return ret;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+			      &epf->bar[epf_dma->metadata_bar]);
+	if (ret) {
+		dev_err(dev, "BAR%d setup failed: %d\n",
+			epf_dma->metadata_bar, ret);
+		return ret;
+	}
+
+	if (epf_dma->dma_window_addr) {
+		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no,
+				      &epf->bar[epf_dma->dma_window_bar]);
+		if (ret) {
+			dev_err(dev, "BAR%d setup failed: %d\n",
+				epf_dma->dma_window_bar, ret);
+			goto err_clear_metadata_bar;
+		}
+	}
+
+	if (epc_features->msi_capable && epf->msi_interrupts) {
+		ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
+				      epf->msi_interrupts);
+		if (ret) {
+			dev_err(dev, "MSI setup failed: %d\n", ret);
+			goto err_clear_dma_window_bar;
+		}
+	}
+
+	if (epc_features->msix_capable && epf->msix_interrupts) {
+		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
+				       epf->msix_interrupts,
+				       epf_dma->metadata_bar,
+				       epf_dma->msix_table_offset);
+		if (ret) {
+			dev_err(dev, "MSI-X setup failed: %d\n", ret);
+			goto err_clear_dma_window_bar;
+		}
+	}
+
+	schedule_delayed_work(&epf_dma->map_work, 0);
+
+	return 0;
+
+err_clear_dma_window_bar:
+	if (epf_dma->dma_window_addr)
+		pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+				  &epf->bar[epf_dma->dma_window_bar]);
+err_clear_metadata_bar:
+	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
+			  &epf->bar[epf_dma->metadata_bar]);
+	pci_epf_dma_clear_metadata_status(epf_dma);
+
+	return ret;
+}
+
+static void pci_epf_dma_epc_deinit(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	struct pci_epf_bar *bar;
+
+	cancel_delayed_work_sync(&epf_dma->map_work);
+
+	if (!epf_dma->metadata_addr)
+		return;
+
+	pci_epf_dma_clear_metadata_status(epf_dma);
+	if (epf_dma->dma_window_addr) {
+		bar = &epf->bar[epf_dma->dma_window_bar];
+		pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no, bar);
+		bar->submap = NULL;
+		bar->num_submap = 0;
+	}
+	pci_epc_clear_bar(epf->epc, epf->func_no, epf->vfunc_no,
+			  &epf->bar[epf_dma->metadata_bar]);
+	epf_dma->submaps_programmed = false;
+}
+
+static int pci_epf_dma_link_up(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+
+	schedule_delayed_work(&epf_dma->map_work, 0);
+
+	return 0;
+}
+
+static int pci_epf_dma_link_down(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+
+	cancel_delayed_work_sync(&epf_dma->map_work);
+	pci_epf_dma_clear_metadata_status(epf_dma);
+	/*
+	 * Link down can invalidate non-sticky inbound ATU state without going
+	 * through pci_epc_clear_bar(). Keep the BAR/submap description intact,
+	 * but force the next link-up path to reprogram the subrange mappings.
+	 */
+	epf_dma->submaps_programmed = false;
+
+	return 0;
+}
+
+static const struct pci_epc_event_ops pci_epf_dma_event_ops = {
+	.epc_init = pci_epf_dma_epc_init,
+	.epc_deinit = pci_epf_dma_epc_deinit,
+	.link_up = pci_epf_dma_link_up,
+	.link_down = pci_epf_dma_link_down,
+};
+
+static int pci_epf_dma_bind(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	const struct pci_epc_features *epc_features;
+	struct pci_epc *epc = epf->epc;
+	bool needs_dma_window;
+	int ret;
+
+	if (WARN_ON_ONCE(!epc))
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features)
+		return -EOPNOTSUPP;
+
+	if (!epc_features->msi_capable && !epc_features->msix_capable)
+		return -EOPNOTSUPP;
+
+	if ((!epc_features->msi_capable || !epf->msi_interrupts) &&
+	    (!epc_features->msix_capable || !epf->msix_interrupts))
+		return -EINVAL;
+
+	ret = pci_epf_dma_collect_resources(epf_dma);
+	if (ret)
+		return ret;
+
+	if (epf_dma->metadata_bar == NO_BAR)
+		epf_dma->metadata_bar =
+			pci_epf_dma_first_usable_bar(epf_dma, epc_features,
+						     NO_BAR);
+
+	if (epf_dma->metadata_bar == NO_BAR ||
+	    !pci_epf_dma_bar_usable(epc_features, epf_dma->metadata_bar) ||
+	    pci_epf_dma_bar_has_fixed_resource(epf_dma, epf_dma->metadata_bar)) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	needs_dma_window = pci_epf_dma_needs_dma_window(epf_dma);
+	if (needs_dma_window) {
+		if (!epc_features->subrange_mapping ||
+		    !epc_features->dynamic_inbound_mapping) {
+			ret = -EOPNOTSUPP;
+			goto err_free;
+		}
+
+		if (epf_dma->dma_window_bar == NO_BAR)
+			epf_dma->dma_window_bar =
+				pci_epf_dma_first_usable_bar(epf_dma, epc_features,
+							     epf_dma->metadata_bar);
+		if (epf_dma->dma_window_bar == NO_BAR) {
+			ret = -EOPNOTSUPP;
+			goto err_free;
+		}
+	}
+
+	if (epf_dma->dma_window_bar != NO_BAR) {
+		if (!pci_epf_dma_bar_usable(epc_features,
+					    epf_dma->dma_window_bar)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+		if (epf_dma->metadata_bar == epf_dma->dma_window_bar ||
+		    pci_epf_dma_bar_has_fixed_resource(epf_dma,
+						       epf_dma->dma_window_bar)) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+	}
+
+	ret = pci_epf_dma_build_layout(epf_dma, epc_features);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	pci_epf_dma_free_layout(epf_dma);
+
+	return ret;
+}
+
+static void pci_epf_dma_unbind(struct pci_epf *epf)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+
+	cancel_delayed_work_sync(&epf_dma->map_work);
+	if (epf->epc && epf->epc->init_complete)
+		pci_epf_dma_epc_deinit(epf);
+	pci_epf_dma_free_layout(epf_dma);
+}
+
+#define PCI_EPF_DMA_SHOW(_name, _fmt, _val)				\
+static ssize_t pci_epf_dma_##_name##_show(struct config_item *item,	\
+					  char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);		\
+									\
+	return sysfs_emit(page, _fmt "\n", (_val));			\
+}
+
+PCI_EPF_DMA_SHOW(metadata_bar, "%d", (int)epf_dma->metadata_bar)
+PCI_EPF_DMA_SHOW(dma_window_bar, "%d", (int)epf_dma->dma_window_bar)
+
+static ssize_t pci_epf_dma_metadata_bar_store(struct config_item *item, const char *page,
+					      size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	int bar, ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtoint(page, 0, &bar);
+	if (ret)
+		return ret;
+
+	if (bar != NO_BAR && (bar < BAR_0 || bar >= PCI_STD_NUM_BARS))
+		return -EINVAL;
+	if (bar != NO_BAR && bar == epf_dma->dma_window_bar)
+		return -EINVAL;
+
+	epf_dma->metadata_bar = bar;
+
+	return len;
+}
+
+static ssize_t pci_epf_dma_dma_window_bar_store(struct config_item *item,
+						const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	int bar, ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtoint(page, 0, &bar);
+	if (ret)
+		return ret;
+
+	if (bar != NO_BAR && (bar < BAR_0 || bar >= PCI_STD_NUM_BARS))
+		return -EINVAL;
+	if (bar != NO_BAR && bar == epf_dma->metadata_bar)
+		return -EINVAL;
+
+	epf_dma->dma_window_bar = bar;
+
+	return len;
+}
+
+PCI_EPF_DMA_SHOW(wr_chans, "%u", (unsigned int)epf_dma->wr_chans)
+
+static ssize_t pci_epf_dma_wr_chans_store(struct config_item *item,
+					  const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	u16 val;
+	int ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret)
+		return ret;
+	if (val > EDMA_MAX_WR_CH)
+		return -EINVAL;
+
+	epf_dma->wr_chans = val;
+
+	return len;
+}
+
+PCI_EPF_DMA_SHOW(rd_chans, "%u", (unsigned int)epf_dma->rd_chans)
+
+static ssize_t pci_epf_dma_rd_chans_store(struct config_item *item,
+					  const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct pci_epf_dma *epf_dma = to_epf_dma(group);
+	u16 val;
+	int ret;
+
+	if (epf_dma->epf->epc)
+		return -EOPNOTSUPP;
+
+	ret = kstrtou16(page, 0, &val);
+	if (ret)
+		return ret;
+	if (val > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	epf_dma->rd_chans = val;
+
+	return len;
+}
+
+CONFIGFS_ATTR(pci_epf_dma_, metadata_bar);
+CONFIGFS_ATTR(pci_epf_dma_, dma_window_bar);
+CONFIGFS_ATTR(pci_epf_dma_, wr_chans);
+CONFIGFS_ATTR(pci_epf_dma_, rd_chans);
+
+static struct configfs_attribute *pci_epf_dma_attrs[] = {
+	&pci_epf_dma_attr_metadata_bar,
+	&pci_epf_dma_attr_dma_window_bar,
+	&pci_epf_dma_attr_wr_chans,
+	&pci_epf_dma_attr_rd_chans,
+	NULL,
+};
+
+static const struct config_item_type pci_epf_dma_group_type = {
+	.ct_attrs	= pci_epf_dma_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *pci_epf_dma_add_cfs(struct pci_epf *epf,
+						struct config_group *group)
+{
+	struct pci_epf_dma *epf_dma = epf_get_drvdata(epf);
+	struct config_group *epf_group = &epf_dma->group;
+	struct device *dev = &epf->dev;
+
+	config_group_init_type_name(epf_group, dev_name(dev),
+				    &pci_epf_dma_group_type);
+
+	return epf_group;
+}
+
+static const struct pci_epf_device_id pci_epf_dma_ids[] = {
+	{
+		.name = "pci_epf_dma",
+	},
+	{},
+};
+
+static int pci_epf_dma_probe(struct pci_epf *epf,
+			     const struct pci_epf_device_id *id)
+{
+	struct pci_epf_dma *epf_dma;
+
+	epf_dma = devm_kzalloc(&epf->dev, sizeof(*epf_dma), GFP_KERNEL);
+	if (!epf_dma)
+		return -ENOMEM;
+
+	epf->header = &pci_epf_dma_header;
+	epf->event_ops = &pci_epf_dma_event_ops;
+
+	epf_dma->epf = epf;
+	epf_dma->metadata_bar = NO_BAR;
+	epf_dma->dma_window_bar = NO_BAR;
+	INIT_DELAYED_WORK(&epf_dma->map_work, pci_epf_dma_map_work);
+
+	epf_set_drvdata(epf, epf_dma);
+
+	return 0;
+}
+
+static const struct pci_epf_ops pci_epf_dma_ops = {
+	.unbind		= pci_epf_dma_unbind,
+	.bind		= pci_epf_dma_bind,
+	.add_cfs	= pci_epf_dma_add_cfs,
+};
+
+static struct pci_epf_driver pci_epf_dma_driver = {
+	.driver.name	= "pci_epf_dma",
+	.probe		= pci_epf_dma_probe,
+	.id_table	= pci_epf_dma_ids,
+	.ops		= &pci_epf_dma_ops,
+	.owner		= THIS_MODULE,
+};
+
+static int __init pci_epf_dma_init(void)
+{
+	return pci_epf_register_driver(&pci_epf_dma_driver);
+}
+module_init(pci_epf_dma_init);
+
+static void __exit pci_epf_dma_exit(void)
+{
+	pci_epf_unregister_driver(&pci_epf_dma_driver);
+}
+module_exit(pci_epf_dma_exit);
+
+MODULE_DESCRIPTION("PCI EPF DMA DRIVER");
+MODULE_AUTHOR("Koichiro Den <den@valinux.co.jp>");
+MODULE_LICENSE("GPL");
-- 
2.51.0



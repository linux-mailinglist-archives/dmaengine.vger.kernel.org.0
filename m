Return-Path: <dmaengine+bounces-10820-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CExSMZDuE2qmHgcAu9opvQ
	(envelope-from <dmaengine+bounces-10820-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:39:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6D5C6971
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B31B303D2F5
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD83A7F68;
	Mon, 25 May 2026 06:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SM97Kjks"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020124.outbound.protection.outlook.com [52.101.228.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18493A7F52;
	Mon, 25 May 2026 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690906; cv=fail; b=c9mLd03Moi4tq8xSkkjjzt0+0V6A/kKeaoJSIakzhsSfWI+nwwL9/UqCL7zlC4hCLjkrXFK2ItXvntQcxGYEXvnzEqCGc3MRjvw5aQVESz+MNn8IKWoNh7DsBTUtX74B6XZNQPvBxzZ44vP6iGk6C9G8/SrGvDJ6t9S7KAdSiAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690906; c=relaxed/simple;
	bh=o1/yWQD9ZkQ5BEL5luHbQS93eNk0ChPwQtSNt2T7GEc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h4qscFIB+0DQ3K2yLcS2nUoDd/JKTa3LWKuZXajMZFc8kPVKbclpDH1SML6g7WUEPAfnE0Rv7QJiHNdyasjvq7iBziAVs1dkjGLT0zpCOpKtVF6X+FOlLxYySJ06YlfRyiPXR+kwPuPWmY12kTAb+0cnwdiC2+vnzLsdvPTUQy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SM97Kjks; arc=fail smtp.client-ip=52.101.228.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxulclYnTR42E092kK7NLtnyWNSF+U0djaRVP+nvQCwA+Whi/Az/ka2DCTWfoS0kf6luMYum6Ez0wk/HXbu9APrhPzEoOynpY6HL6/Q08/flf2gd7lNE1M8KdlK/jZ0l48f7vsKlG5M1J0ccQlr5B9GJ0bTGuxBPYFCPm9FgrMJpiQB8F68itfpVx56+PASQLBmp/yH1bZJzjt6dkLyR7th8T+0aompoRC49d95RWx7X0rwZodNTlFYbORFL25urzxBuKxARi1wUlAVNnP+wOhgvzV93OEZdQMZw/EqUALc5bX/ZwvvRM0MNsA54QEgL6mDdnkYYDNsVq45iIrT4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axsvsao56DcJ0S/Lx5q661hoNFGsjOyIWpkccmeRH10=;
 b=gpwwGGooxR8DC0cuu8iAJaegIzMjEw1NPYSXyHb/yS0gE5JV6WeU5xn16WxoUKRw003k0TO3INvkMgCzcmd+IDJjyIWwNe0lZPoFaiPGCowWl+7RiVtG405lkxggoYlZKz0esJcpo/urgK50Uvtf6goCjFfoOArMyIoEEwnjAccURa25x+v0h8zB7UiEYu6KKOVh/Wjp4/63MT8xOMG8+Nsyrdiu2IfCXOSEtNwyGQQL+LXPlKHqFx23pD727OXsVLaEZ5reuC/0ZGTvanYOLDsx+TsEcPS6qgJWYxDRrVQ3Wb2rN5mpRu/vhP/aqcTYFw2PVjaMDAzh+g3h/SeZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axsvsao56DcJ0S/Lx5q661hoNFGsjOyIWpkccmeRH10=;
 b=SM97KjksjNJv2+NiSbr/x5lZ8tvApkppgn3AwfX72zrkkTkVn9IB9IHS5LE+jMZyWyXylSiOMyHoYOh6xQDwwjzZcdr9BpxVLX1YjqpLT69HNvF73/KvZSM2XK3dVYs6z6vW5sK+mNKJGXCP0UdUzfATeLhnlA8ExHxJpL4DsWQ=
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
 06:34:58 +0000
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
Subject: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function (part 3/3)
Date: Mon, 25 May 2026 15:34:53 +0900
Message-ID: <20260525063456.3317509-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: d44c56b0-437c-498b-7cb6-08deba27bdb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|921020|6133799003|3023799007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ckymHmlDQM6hrbPcdC6iig0DzTi/oxAPami5d2FdtiQz6duiId/dmIptTPEnTrKjwD9uMSrmzvRS1gZdKrLNP7wV7gqSBFRQ/vIoPbqZQuwdfyaxNs/LzdUq3kachFuGexvZJx0zkgt3xZ4+lov6byXwxhYl3DEco6ktRerUB3IJO473a+Q6/cpqfYWJe4m0RIfdeKHBALTnrzWcL+VAfUYVcEH5uFl+8UtcFVeWTj4dVw0u6z6cIbj5ee6gUdAMY6F1ey8z2aacFXDhqLtLF8uG+3fqls0N5tZhsG8lm7OXKZB+ZbfqXMZjtBpwW4zMaN2CS3vmWkf5rdg/eRXaC1og8POmwz3EmBYiiPPmmdKkN4bIo5vHgShBI1p4EC/oWTZd724ijucqOTSNk0Ebp7A8Gr1UXnHc60cwTaNMiYB4w1+Iavxu2r9yf1Y2ARg8RgpveDok/s+TLMbCzGXFuqVQMAprV2w5x6baNpjpHnnDVT6+qTX8jgsUqXe0rfn9rbxBIIXge500H0uccGgqtBHuGTBaFg+U2jw5W30OCtbi3IhnA4njesBy9LbG8HKM843j5SYVemSCOzilRXmRL6HJlV3VYZeJu57A2m6FHK5BxAv7hGwADqPNv2vfypFokqwvw5NIZvLhitodTX9D2VDaybWyDO7f++UK5FMT+m1J3msKyRKbZruf7kX28nG7VWl6aiGjjMvndt5YYdhCyMX+6J20RGdQieuEmkJaklg8C83lFbRijf3rTFffpv8p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(921020)(6133799003)(3023799007)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8g+kMo1ebEQOK6ps0VN7+w8JjloOXcZKXZrJMc7RMovsMGhfpe0O/YgC+Z4?=
 =?us-ascii?Q?Gbczptpwx+606QH9slDs1ohwzukYkQvrVjl1nm1RbmHdZArNVdDNCjjf78kJ?=
 =?us-ascii?Q?zTFR4NzKas+GoihY4gN8mv8iK0atpEefW1mqrDfy+1/3lOliaoeSG2ehmRoO?=
 =?us-ascii?Q?iQXjCqnX7YsHUgvUXSMhePjZukv1wfp+UpGPd5i/ts24wTz6URZeMvetIUer?=
 =?us-ascii?Q?IWtW1Ar9DnIcpSfTqX90DdUyr6GIZccjas5dmUYLoa9BQENziGQUJrq2vkjQ?=
 =?us-ascii?Q?f0JxbHTbzW3AAJEqU6J/78akREjh+0bQpCU5wbjSeJp7RB/3/WhqRgU4Adci?=
 =?us-ascii?Q?ldUThInvidcT2e2wyTMcnNzXLvarPD+u6ulOsriYhlGhRTUCsIUljKgClOgi?=
 =?us-ascii?Q?0LNA1+dJ6f5x3C4rPVbUtxLRwkYQLz+azZqoiskW5EYyh1PE+Rq3rbFx9Sya?=
 =?us-ascii?Q?AiWOpoipH/mTiU2AQnw6fakOWkKxVg3s0CasOkXXcJbJj18cPPNH98ak9pl5?=
 =?us-ascii?Q?j7lX1ihYXnBSheIHohjNKAz8uO094LiC42Ka7eUNxf5gbVSkt4UMD/7dCnhH?=
 =?us-ascii?Q?4oQ/rMiaI/pfCMQSfuym0hA5oqlTh5mw2KwHJ/17cLJtsUA3LLldMOC/3G7o?=
 =?us-ascii?Q?HjxZqw7t7werQqQhj+kDTt4ninC4DLUYp/eCb/mXFkg8kTQgJoAo6pEgVosk?=
 =?us-ascii?Q?cS/mudMW15M2QvjOOmzLg4ILsdG/O+2Uzp2Cdmw5kwFAqPqdXK2ANMULD8Mk?=
 =?us-ascii?Q?TdRoc+Vkh0oEXFr+uvXiG/aZrBbbKP1cT7/0odRMm3EDx5yX3mBZZMybiuwT?=
 =?us-ascii?Q?7udcmm6B8mj8Bscxy1U/1YD1YT2qP9xgocmB/Rxnfyic+hfnIhwM9raOlA2y?=
 =?us-ascii?Q?kAx72CEHDEd8YE0OtdY/J/wxaK27nI8U5fV+87k+QlLSTPpZnvqKD2M9n9wM?=
 =?us-ascii?Q?LhCFk+tt7B7wAuovwkHtW01EtZXUalsHCQwy1kl2CHhymrTDD4jJT6IrXyG5?=
 =?us-ascii?Q?mS8R5KlmEVa6Yr+3U1tJ0j/eYS0/xs3Y2ZbYN6N589cKoVhTAuKjlTxBqPQy?=
 =?us-ascii?Q?4dVQDQXy51vpN4UW0YT4lWCg8IOr+KgZgVeBc/qT5/bmAJR9BMsDmvdD4+aR?=
 =?us-ascii?Q?aLAriX5wtiWHjkCQDtWgwJ2KpM7gmJqMjSlWHI1Y9d0Ov+29RXpAx+G9C/lZ?=
 =?us-ascii?Q?i4wbFBnhmYugoRoZFlFAUL6soEzE5LK1lXqX1ik5V9bAhPDTr3VaY4L7fTv5?=
 =?us-ascii?Q?R41E3U/6BcodJGGLDj8ZoZJfTDJih34q+5QAzmcvOQoQq6AKCp1QBCy+QgMc?=
 =?us-ascii?Q?Qa86Rz2fwv/Bg0Hp1Xj/D1nv3vR+SJ632+oyuYYrGtv+kqF1SpqvIAqjKhvX?=
 =?us-ascii?Q?V9uZLidmwzKtaXrqlZe9kESljIn8NxdWsy3MS9i/Ba6csL9WBUxBnVEgG8Tn?=
 =?us-ascii?Q?K4FAu7IATknj+C1RVsklS8WAEybnoaflT+7hiwT5miw3daNPkoAILdjsMv/k?=
 =?us-ascii?Q?oXCnjEMC0/nbcg6OqiPRkBj7KsfBAPgfv9E9ZSTBD1wByR32MLBHFK7/Fl0r?=
 =?us-ascii?Q?J4r+flkjldcQtOqDRWbg7UPYQvZQPcprbhzPxEHNXoHlnSx13oHOokqW/T8Y?=
 =?us-ascii?Q?DhkMonryxn1K4BvXd+/3Thiv5BSjxXWvNJr8nhheBpsq3cRr7vKw0EdWcch5?=
 =?us-ascii?Q?zdWwsw+luiodL8eXAycFMEqTyLbAYniLA7sIn+kPnbmnZ0wOw97RbyYJyL+u?=
 =?us-ascii?Q?90Flr0iPb+koJuwF9ogjLcWqTEsRojdLCks1MF7EqUnvLw+odajN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d44c56b0-437c-498b-7cb6-08deba27bdb7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:34:58.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWardCLgMJGkuRcSG1hBT1Te3Wo5fL1tdUuPDNEaT/SGTrQB5kFG/Z9eP+Xttopj11P3ETOfxREp5m1r9v3tTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2042
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10820-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 2BA6D5C6971
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is v2, part 3 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

This series adds the host-side metadata parser, the pci-epf-dma endpoint
function driver, and documentation.

The endpoint function exposes selected endpoint-integrated DMA channels as
a separate PCI DMA controller function. The host-side dw-edma-pcie driver
discovers the BAR metadata, requests the final layout, and registers the
exposed channels with DMAengine. Host clients then submit transfers through
the regular DMAengine API. The endpoint function keeps the metadata BAR
stable and uses a separate DMA window BAR for resources that need dynamic
subrange mappings.

No fixed PCI ID is assigned by this series. Users provide the PCI
vendor/device ID through configfs and bind dw-edma-pcie explicitly, for
example with driver_override.


Dependencies
============

This series depends on parts 1 and 2, applied on top of pci/endpoint:

  [PATCH v2 00/12] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/dmaengine/20260525062420.3315904-1-den@valinux.co.jp/

  [PATCH v2 0/3] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
  https://lore.kernel.org/linux-pci/20260525063129.3316894-1-den@valinux.co.jp/


Note
====

This series touches both dmaengine and PCI endpoint code. I kept the
dw-edma-pcie metadata parser together with the endpoint function so the
metadata producer and consumer can be reviewed in one place.

If the general direction looks acceptable, the dw-edma-pcie patch may need
a dmaengine Ack if this series is routed through the PCI endpoint tree.


Tested on
=========

The RC-to-EP data path was tested with a small out-of-tree DMAengine
client. The host submits a DMA_MEM_TO_DEV transfer through dw-edma-pcie,
which uses a DesignWare eDMA read channel to copy host memory into
endpoint memory.

Tested with:

  * R-Car S4 as endpoint and R-Car S4 as root complex
  * RK3588 as endpoint and CD8180 as root complex


---
Changelog
=========

Changes in v2:
  - Follow the part 1/3 and part 2/3 v2 channel-claim model: pci-epf-dma
    now claims delegated channels through DMAengine filter information from
    EPC auxiliary resources.
  - Select raw-address dw-edma-pcie platform ops from the endpoint DMA
    match entry instead of using a match flag.

v1: https://lore.kernel.org/linux-pci/20260521063638.2843021-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (3):
  dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
  PCI: endpoint: Add DMA endpoint function
  Documentation: PCI: Add PCI DMA endpoint function documentation

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-dma-function.rst         |  182 +++
 Documentation/PCI/endpoint/pci-dma-howto.rst  |  200 +++
 drivers/dma/dw-edma/dw-edma-pcie.c            |  374 ++++-
 drivers/pci/endpoint/functions/Kconfig        |   14 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c  | 1366 +++++++++++++++++
 7 files changed, 2138 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

-- 
2.51.0


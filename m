Return-Path: <dmaengine+bounces-11663-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y6/kCHzJNmqNEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11663-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:10:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B89776A9523
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:10:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=TtBVgWpo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11663-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11663-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFFAE301C587
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493012E62A4;
	Sat, 20 Jun 2026 17:08:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37D2DC783;
	Sat, 20 Jun 2026 17:08:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975338; cv=fail; b=k9Zkzr09vPj48FfUZnwJBkMvC85UoRxY4Mp6LEilR06AQM39Alk1GY893zwowKcdvk0xXHL4/ZLOynr0O4l6q2yOFQKtv21AwBFMYFZZ86vS0UYU37OZrb8v3tDcpll+Q7chUFKomAb/GPg3kblmKKSjmmo998AlqqDpwR7C7BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975338; c=relaxed/simple;
	bh=UlUjKcRzh0zgOL/0vvCi960g2S46DCPlRe3QfIDz6CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uCAWucPooN2OYmIzQY5FMtVRUGBwDGgtZeZKxAPF+klbK/OhDtWFm8hXpBDuEkXs2VeIp7CkrXcU81vHrpaD3xPysxvDbtRbXvzkiIKs5v2e1AAublvcyllqHN6yerF3YtOc27vW3x90vhNO8AnOaMhoe43E6meSrTHLat/GibY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TtBVgWpo; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXEZydkDuhJ7xt8ZaLOAwIjQcMZ8qlOIsyOY+lxIc67Fn6/mjp6F3PzJXZk2KI0aWA8w7f65E+0HsZM2LlWJkLbuQ9LwrwNbtISLvmLMdmkA0Q//l59akB1oZ7qJ4ga9JUKTR5ajFB1gnD8eXp2EiWhYzgELqo55MjAlf160sgYNVA2rJZYxIr3a9Znj8SudeIq/eE1qZATBpO4La70pNen71crWtjOSYPqgqSzHnGY9b8LMqg0VestQTKvG/tp97ReXxuJ3kENEnTKUBHUcMUu18E1k2QCYN/EMlZkF+D9txGX6fZgAd/MaMH/gXJ5U3lQ9Dd7SaszDdeYSjGgm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQmC9EbJ8A2MTUbjJYzlZjpfq+BzB/NJTKzxSdqTXr8=;
 b=Ao2E/w7NaJxyeHWbAWdUSf4UK8k5xQ9zYPrQvzpN1OIaYM0zdHGQ8jAasY+WDnAgnQkIArt7335FVPgiC5BNCCUshEpG/vjEmGhl6eI6nMt3aFGjeZM0ORi30ylLiAUAdVVQbs+RoEinuMDaDTNqWU5sS4imi6GMhnnhTZOrkCNFfMrsTTejiSXxo+xNdW7OF3eFbAaw9ezvkVoyZ9ZwINNakr3Nic/kcmeEaMwkyoesj4BY1zmTiQhbhneXYYzZpTlD3aO17GXc6u6apjlTi2wPKkCfwpOUwtFifFQNrek4KLenSHcs1VDi9WcHd/OqXKSbYYJ6EVYbNYeCelS2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQmC9EbJ8A2MTUbjJYzlZjpfq+BzB/NJTKzxSdqTXr8=;
 b=TtBVgWpowTKItY5a/7rO4PoUg6uodlFr2KBZKLA5LQAlag7EKzYHY3k11QYNr6+DuNo74/N957BdR8hPjy6+LuXZOPOEB+HVc2vXV11UGbc9ANrm7VBK03ViTuqNyiVgDeK0rvz7Rl51ydF0DQgSbfAuPAhkyKUJJnDSG8HVYME=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4352.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 17:08:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:08:51 +0000
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
Subject: [PATCH v3 0/3] PCI: endpoint: Add PCI DMA endpoint function (part 3/3)
Date: Sun, 21 Jun 2026 02:08:41 +0900
Message-ID: <20260620170844.3757241-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0280.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb1594e-1c59-4b78-797e-08deceee99fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|18002099003|56012099006|921020|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vrTQ8BRVe7+WtEC1ol+KHyR2K0XwB8j16nOnwZh9b0m11Ogo9v9YnEpXDwwaNWvKY1kfb7c1FXQBE5uke12bGp+7LCopnvg3jrqV4f0GbqixiyWRKiVd8bubHeZVsX/hKQWPcPlxSnsdv8qBk7hKx0AVOkh4aURA/DYe03t9wec+mifRPre6vqyIB0XrzyOSFnKQRuJj+gLs8DtGlAYg1OOPL+nhPrObK2qoXOZhRE0Aeh8T17yNlHDcnIhqNOSqOzf42POiNQPZbP/IU+EEbiOhBrcYxwLMxiheJH07K3u3qR2ghRFGpS5gg+1t2S99TE8/89Xs9fkEyRVldXgZpNR7c/Wq3m+fdzik0ybxwAbkst2SiSOnGQtFlMjJMp5W7qLkYD79EhTcVEB1RI684LOZgsqd6jlWJXBNkzD0Uq0m2tDYjbvfR36o089rem7u3+CMp7KSJv3LY8e/3z762jGat3ivltVkj+meyEe3BZ2OVHeatYxXAeOuK11r0e8ZiMB/kwJ18KTSBZ942P22gYNS4j8KDQG6nDuFF4favuX+K9xJWEelTRgIdR/pmCk96egtVxmCCVMR3+zvk2KUPYzRo3Y3zO8XHH4No1/EirnXkHqAKysFBcFYBXbwFlhmq5ynw7FV4TyQ17D3jvZSQEceD6qWA6I25rDCFncQIQQlyr7eGFZylwq7Sbs9TDkDYLEEaEPpQkGufAierQOpJw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(18002099003)(56012099006)(921020)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OTuLPqTakpgQvuwG+KlHaskD3Ff7a9/Kc8g4J/ahC/jUwBw12APpLTLd91lm?=
 =?us-ascii?Q?u4YFR//FI2fXuztx+6zeIE7vu5Gpn1BsZZGe2Y4T0YoyDg8oYi1oCXDKA44b?=
 =?us-ascii?Q?3OfnEbI6VCeE3wVqwdNJ+RCZSERgzD2DaV0V/uitxjR1BHLjYAhT7rpl2ipM?=
 =?us-ascii?Q?wt4BibPtFI6l+yxkIV6RxZBtfcTrj28mrEenVOVPlNajk2dxiR2/HoduZgs7?=
 =?us-ascii?Q?ORUJuoTSCUYcB1c4BSRkFg2x5dFy7bHTfsmHgBU9dGECM9Wm3hnM4fMtnlyH?=
 =?us-ascii?Q?IUR6QLDzUsNryNUwZpeGvu9PO0SHBUJO72W0PSc8hySvsv+UY9wrMt4DWcQH?=
 =?us-ascii?Q?OlRtp2rTNwKVc/0qiKAPix2Sv+ZsJbAqNwb+eRA2Q7q7aPi4UGvQJGSyH5qh?=
 =?us-ascii?Q?T7m+z+01/l5H80XTY5f3ZD84t831xpRs9T3r0BeQkXSa3Q4H7AbglMvyE5ll?=
 =?us-ascii?Q?HJzahQZ39GnB1xTPYsX2i+cjSE9mlQVtontRHGIcSOczAr5wzmK/sjsFRoyF?=
 =?us-ascii?Q?l1+BsapH4LAT/HUSAfD0SHuTUPRHfPyj9ozYQKx3+WnhJ8OM7w1DNMBwQfY4?=
 =?us-ascii?Q?rG6RmQBu5i2QWGmKY6nYe5kRdPsxpLRjV2cwnrCFTR7/6y7pMbEnQ/hyBmRp?=
 =?us-ascii?Q?QizhMdLu4dBQFSM0P1qGryoRhppGtHjK/ErDVGfq92Tv+59PIbfxtkoUnDvK?=
 =?us-ascii?Q?X+ZBpYK1uv5wo91gE3+9PzRKQmxKFW47Hi6dSLvEJqvJuPoeyP7p6czNrr64?=
 =?us-ascii?Q?BxAvxivzZoKf60drSMCKS6ZRcO3yrO13w8SOyP/XVAG53vgAj4CIDhejQH/b?=
 =?us-ascii?Q?I3LaBNguTqTWNh1JPn8z8R2AyWYjzmoMvu0YPEj6jJMb1rRo6VO4Cgals/aE?=
 =?us-ascii?Q?ijWfeKL+UZOSRIjxahi2bXsqUcn1tKPxYMm1uPQu6A8u8WQXuQe9B6IZVgq4?=
 =?us-ascii?Q?gC5qfIScFwPDp6Bylz0srDGfpnBVBoEsJX8raIsRd/9M1OcKRQSYzcJXZ/Kz?=
 =?us-ascii?Q?Wv5GtCXUXkYqoAOngtzgu8euzLE6YzjsX0kkAQ2odFdgBgwESBJXBbUdOvUx?=
 =?us-ascii?Q?jY4CBuZgFKIiQ7QEUkioQYeCN+4FfjmKudqb6ywxyo2Kdo2rH+88K7x6DRyT?=
 =?us-ascii?Q?EUGFlauwfWFLYu74JQVmmRu/doyM3PyZUWtgrhk/6spyEvlsiBdAXrl1VPK/?=
 =?us-ascii?Q?uDSpLZ3DcaW98FqZ7KHO316t5mR29XWp4M0CCgcV5nQVJfvmSn0JeTOmcDOU?=
 =?us-ascii?Q?KM0e3UwAxLS0hQwvfWWlQS2ovd4P4ga8oJLlU9Rp4LRrb2UKq5meHqKJfViG?=
 =?us-ascii?Q?ZtdLD3V9x/lCSFEabnl/keQeitPJhMPeoSJJpd2d0d+kZ+u+PCzQSKovH6++?=
 =?us-ascii?Q?nmIyZPUibKGYEDiUKeD/eSvI8JCgxtt+el5htJOuf2IRXRp6asoJ+U0ax2HI?=
 =?us-ascii?Q?0kliBFW0iAlVXMeys3xjJHfTWxuMumhyhq9jz3YnoEfaEXC1rf6AmdNrMjkr?=
 =?us-ascii?Q?zyO67I8lAjbHMmxnWysPoxp+raD120p/SvYJF92fMW851SPQq8FSN7wxIcWH?=
 =?us-ascii?Q?4+sVvre2zsQVrhGWT8zn6DD8C0quSm9X/MOcemi9wmGS5OQpJgF5wFqAlG/0?=
 =?us-ascii?Q?2P3gO8VDx9J/+pN85QqRsYib79TXSIXPI2/CPEt3+0/fm7nCK3t3SN4v+NoB?=
 =?us-ascii?Q?mWh5AN/hgoJMUJGHfJ0NkbJ6a3KqFeDOSXFkg0Z0hUD5uPe7+cf2zPTNl4Kl?=
 =?us-ascii?Q?2wwk61ytv3H0jmkj051qKrlHPz6s2vEFPeKbw1BQ4v6i68uF6mTQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb1594e-1c59-4b78-797e-08deceee99fd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:08:51.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xODbKtWS4dfkUX8DyyGDMpyXyizxgfKQMKHxzeyva9URkqgJpaF2+lBIRRJCeSw39OjDeUix8bQSIUcclYGaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4352
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11663-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:arnd@arndb.de,m:dlemoal@kernel.org,m:cassel@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:linux-pci@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B89776A9523

Hi,

This is v3, part 3 of three series for PCI endpoint DMA.

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

This series is based on linux-next next-20260619 and depends on parts 1
and 2:

  [PATCH v3 00/13] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
  https://lore.kernel.org/dmaengine/20260620170040.3756043-1-den@valinux.co.jp/

  [PATCH v3 0/5] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
  https://lore.kernel.org/linux-pci/20260620170438.3756593-1-den@valinux.co.jp/


Open question for the full series
=================================

One remaining design question is how to support endpoint controllers that
can expose only one PF. One option is to keep pci-epf-dma as a separate
function and require multi-function endpoint support. Another is to fold
the DMA functionality into vNTB for such platforms, similar to the earlier,
likely superseded, separate series:

  [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
  https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/

My intention is for the first real consumer to be an NTB netdev/transport
over vNTB, using this DMA path to accelerate data transfers. Embedding DMA
support in vNTB would make that acceleration available even on endpoint
controllers that do not support multiple functions. However, it would also
make the vNTB code significantly more complex. The separate PCI DMA EPF
model in this series keeps the design cleaner and more modular.


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

Tested with these endpoint/root-complex pairs:

  * R-Car S4 EP + R-Car S4 RC:
    eDMA unroll; DMA register window mapped through a BAR subrange
  * RK3588 EP + CD8180 RC:
    eDMA unroll; DMA register window fixed in BAR space
  * SpacemiT K3 EP + CD8180 RC:
    HDMA native linked-list; DMA register window fixed in BAR space

Note: The SpacemiT K3 test used the vendor Ubuntu kernel
(6.18.3-5-spacemit-generic), which includes pcie-spacemit-ep.c, with the
required prerequisite series backported.

---
Changelog
=========

Changes in v3:
  - Select endpoint DMA match data before copying DMA data and require
    driver_override for the generic endpoint DMA fallback. (Sashiko)
  - Accept HDMA native linked-list endpoint DMA metadata.
  - Consume logical DMA channels separately from descriptor memory resources.
    (Sashiko)
  - Delegate channels through the EPC DMA channel delegation API instead of
    v2's EPC-provided DMAengine filter callbacks.
  - Allow HDMA native linked-list channels to be delegated at channel
    granularity.
  - Preserve HOST_REQ across link-down and retry DMA window submaps on the
    next link-up.
  - Drop trailing colons from documentation subsection headings. (Randy)
  - Document HDMA native linked-list mode support and the current non-LL
    limitation.

Changes in v2:
  - Follow the part 1/3 and part 2/3 v2 channel-claim model: pci-epf-dma
    now claims delegated channels through DMAengine filter information from
    EPC auxiliary resources.
  - Select raw-address dw-edma-pcie platform ops from the endpoint DMA
    match entry instead of using a match flag.

v2: https://lore.kernel.org/linux-pci/20260525063456.3317509-1-den@valinux.co.jp/
v1: https://lore.kernel.org/linux-pci/20260521063638.2843021-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (3):
  dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
  PCI: endpoint: Add DMA endpoint function
  Documentation: PCI: Add PCI DMA endpoint function documentation

 Documentation/PCI/endpoint/index.rst          |    2 +
 .../PCI/endpoint/pci-dma-function.rst         |  188 +++
 Documentation/PCI/endpoint/pci-dma-howto.rst  |  201 +++
 drivers/dma/dw-edma/dw-edma-pcie.c            |  380 ++++-
 drivers/pci/endpoint/functions/Kconfig        |   14 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-dma.c  | 1420 +++++++++++++++++
 7 files changed, 2204 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-dma-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-dma-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-dma.c

-- 
2.51.0



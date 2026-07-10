Return-Path: <dmaengine+bounces-12306-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q8p0CCGtUGoi3QIAu9opvQ
	(envelope-from <dmaengine+bounces-12306-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:28:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B773873D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:28:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=ZxO5NOUo;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12306-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12306-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18D9530277A5
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508E3F0ABC;
	Fri, 10 Jul 2026 08:27:40 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020121.outbound.protection.outlook.com [52.101.229.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08093F076D;
	Fri, 10 Jul 2026 08:27:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672059; cv=fail; b=f1J8fZkQcQp5078tRJnNEnC+pqlvFFxfvvYIW9ezuMztyQM4Y4nMt15QUseisihY2pCGCUN+HYFvua7CN6ndw+zUz+5T4NF//SiHVjB1L5x6e1Slh496rh69Jlw3xzvKKnq+nrMQ7ryuwZ4XfxO1nMZ2aiAUZuELjqa+fkvVZ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672059; c=relaxed/simple;
	bh=VMwfARgA+b8SJWaGaH5a/Nw4Y2vEieiN5At4J5LFYeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvE4TxR0sv4PmTU8BAZGuzFBjrglSH46/1X8rLffLEKbyNnlcXIUHs31e9dXT4jGcX6tpGJuUB81jIUpqWZVW0ahJcVhgJXXEJxv1QKBkL7CAJWrvT1EvqMr8tDY70QtMAhaRPql57pXVgLLcmTj2XPhx6RDIjFWA963Ul5WLFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZxO5NOUo; arc=fail smtp.client-ip=52.101.229.121
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6qSKxEVKj+DFbAOkcPXe0nwsCRGdWceeTBF2S9aQ6ahetKjg+vQqAe6hrNDtKrkZFTeTYVq9z6h7MKjM4MQMaC9t/HWCQxFFt4/h/WSBwZwyr3dttv/tdkzmcaZwImsDm4l2nEL6Apb+cmI0IHRO6mAyAAvFm41n394xZ1t/RW/eWnnOGf2cgS7yw0/E3+d7vF4ABS+DwOMArfzxHfsnKCeEam8mkuUZqCYk0vgPVKgm0Ehf3c2I4LL+RPrwP3LOdFD+DkU6PyBS9tCmRVRfTYpdOtXWEP80aux3hY3kX3bxrGbE1lOaQE4hLIKmWDQwuY1yw4tTNhUGduYGcZHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUcOa+8UDyLuaaeY5heJjZrp+MvRqOcnHJj66mhSYMw=;
 b=wgL8x5Om9r5pg5+hQU7Ij2IGLiAuwl3+8SfS2CCKx8myEWOPJ1IhFixBLYngFsd5gs0yiDI2BFs4Ba2Z/ZCqkGgDXjNmyQTW8xwA1tZUiC7UUo7TVdpvY+YoofMa+0pKLYMdxNw6uRVGu3hbP9Tb5ny0qYqyuEaNTYQhhSDdC1cpiSOkT4azJOIqP4mdTGJKcdpzUy+CamN8khoK7uYt1+9jS/CE4ON4SxVEaWcjesUTUFoOLjG9HGj/YTagBM8C+d5Ow8jRUNauzA4S22MGCp3fzxElhUJvEjIz8U4cRiIeLGbcrPYiKOUZ4wvMkQtORoVADaq7z96K/LMtQgTJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUcOa+8UDyLuaaeY5heJjZrp+MvRqOcnHJj66mhSYMw=;
 b=ZxO5NOUotqC9UbHw/pVlVJAD4VyEbC9eHSrzYsD7A12L+QS00IJWZL4kIpinY4/nrx54nt5dei4o6Bt3/50FN1puy68TNFxg4/YOCzS+nYhNcHuYS5DSNotIcUZHNanJmdtoO+AmimQ3dEc22iVQmcpmyebNlYG1diw5HZ27IEQ=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 08:27:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:27:32 +0000
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
Subject: [PATCH v4 1/3] dmaengine: dw-edma-pcie: Discover endpoint DMA metadata
Date: Fri, 10 Jul 2026 17:27:25 +0900
Message-ID: <20260710082727.2397253-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710082727.2397253-1-den@valinux.co.jp>
References: <20260710082727.2397253-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d76e37c-479e-43a1-60b5-08dede5d1680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|3023799007|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	nmTRvwq61S/oGpMA97nTqi9f3e1hpDVgoOLqh1r7ycSEpjRuP4JH98Km3ziCxYvbUy57XNDpAE3CG9p5FAluPkWr98HVqKh4QdVuNmLv2igdusVVr0i36KYmyNv5rFYNgu9TlSN3PE8E5y0FWwyTZK/fxnBl16VN/vMPwLlU+27GLlfgPlX1hgE1IWv4VlrlTcBqRR0EgB/Kzu/KXKaYCHR94rZ2zrm4vgNKgZXeiXAPGSneDGenHi4zKnGr8rm6qOfUyhJCMgpUyvA1+W2ZqBZK2gk4EIipIrxLhJNA+itq/rnRz3aIkLm5X7txV2q2EdCLWh0czx+u9c0ePTnQ78lnGipjsJ1EX94ZtEwHsNJXsFeg5qfnv/7+f6LrvaBcaJjmwczzrRb0VHCZgfs0EXI5rPPN2/eLc+Ls5XFo5A6jDS+DU0H+VrafbmCqG73kh4F22zeHXo6Mpw2YixeYRB4f9jgJmWxq1cUA1FMpz8iAJ2glYxxHJqLSUij4WGjmRsEwH91Ja9nL9SxA1+zNXyoRjbDCew8+9+7PgntyLRZBJ0SelgZev/m/+QqR0F9NmABtoUHFcT3xzUPz/P1i6ETOX8cKOOCMQdwyeQWukeypapX2bXtxd+XUh+inxxrISX51Lc0666k5eBxMuDDNgDKfqMivq69DY07AR1ltLWl38C/t2f92vSya0piy7xO/Wqoq/jY8hccviyjtwJvfVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wgn7uo0tlwQ3Gyb8k+rlRX2StDlfDQaR93nifRZkaR7I24GnEibao9C1iXb?=
 =?us-ascii?Q?NaXE9reXqoae2oLzCP6k9+irmTlSbp2kjo92wX8/SEBNHie7xPbPB2U8K0hj?=
 =?us-ascii?Q?aRIfatAgzb5nqdN7i1Ef9ORZKfqMPcL8qi0J9AMYmIMaYj8paafJTiN0GvjJ?=
 =?us-ascii?Q?xob7AgIZLORG3oFGYX7c1vT8uk2ovoo6CyFyubLiqOM5EC2Z/E1s7LuCfvQt?=
 =?us-ascii?Q?LPiBGJRCMBSJ/ka9lVA7RmRW15/EWqt7R816SFntdkLeUJ//9Lou0SO7YnF/?=
 =?us-ascii?Q?sgs24fDIgQK+JNaw5ZV8D7/efsTH0nruvJcnLawX7tPTOV0UnczH8Yi+orWL?=
 =?us-ascii?Q?gZKd/67Cw028E0dx8EwNu+gnSqA7R3TjZljiyQi32UgJmQlTh3vIki4GOqvy?=
 =?us-ascii?Q?tsECYdUtEKL4AC3lvmZB8AO7klSYihovorO5rRGbYMkc9/1NEHoydMZoMyVs?=
 =?us-ascii?Q?2yUkxySQ+mo61ys3INhnUJiC+n2b75MCWEqZP8c6cy2jnpS17imHnhF+VK+c?=
 =?us-ascii?Q?+clvIglKG8bxZ+leyNLZi8+PMgLBuooOZVPIkxJPk9XtdWW/vD7ipmZNJj3R?=
 =?us-ascii?Q?skLMHGVXXLupVmDberMMH3rdVkAeyLx+MXlluDRKbkDuqfaI2QGsSkK5Y3mx?=
 =?us-ascii?Q?Ow8QY+Su600Jd3tKm/oytPDGcrFVJ8GP8iwYEB1OhUN2+i917EOoQJX9Ekq6?=
 =?us-ascii?Q?JmVD1bJj4Eb8GjkMrKdnMU8zVbN7fFTs40Le+yiGYsocwKCNQqxZITwYSD/p?=
 =?us-ascii?Q?nCI1s17ENhiAZZyyEm1iPLz9GONpLGMgS5J6paiHqCh7Y1RgVTWii/4Ma2G6?=
 =?us-ascii?Q?8zpg5l/68RhfUeA8dqoKCfgboWV65bf5ibS/wyuO0C/aNqKhLgiO2D7JWn+o?=
 =?us-ascii?Q?zOhj+HGJ6VrUTh0RUeISXnbltOQ6KF8TlKeNvI5Ac9ZfMiOKBV38mBqkpFin?=
 =?us-ascii?Q?K05l/X2haiCCyiBHWU6ddUVIgu+2xAh3C2FAP2C9y6ItIeQFKZUVsSjDaA/5?=
 =?us-ascii?Q?Vd5CB1d/C5TiCyx5MewJApweS3yrCUXG/ehrKYLb40O+I5k9LDcPHPXJfVf8?=
 =?us-ascii?Q?X58kYTqM/siQEB0eBuW1duJ5SrkoimbLjTVJQYDl3fi+toTNjJXp5t5Fp0Ll?=
 =?us-ascii?Q?IPA53kM8hgUCQSULDvu1vdrj8dG9J5fJuBkMv6rAhbMhf3IsAVhUskqYY3Ve?=
 =?us-ascii?Q?SUK9w1+69Trj5+cGD2xbgQPc2kuA9y0TOPgrbKjpad5NzvC7napgQPMDvXvj?=
 =?us-ascii?Q?suiZeHuOBPuDJEcJarD10VUGzWQ5aDEmF6r42YPjlkEF8ld8/YJvx/KPGTXY?=
 =?us-ascii?Q?N4dAYaS+wOukrdOOdnQgJiLMj0MCrZ1YpdNRU1mwaKjX+uIDY81XzNIZYLFO?=
 =?us-ascii?Q?NA3YBBNwRLAifWr29GeJmSEo/tQrZbYufRBf4RxPwoiXvyaUgKAKJB7NZGDB?=
 =?us-ascii?Q?EdQ10ohLC3x3YCUckzzlC663/Dm5JZ2arzD8L1PGW6zJJq0w05p89TgVDbmP?=
 =?us-ascii?Q?tkWvHLBZpcbqUoXlU2XVqFF9pRAq2y1+bS/Qs/vrgUloq/yU7Xht+26N4VTv?=
 =?us-ascii?Q?Lwq4PsVk2TLX9/bZSptdhB+6kb2F5EC9COPMRdJVzn/QgYSiXodrWYHZ+aX2?=
 =?us-ascii?Q?ZaGs/QSYx/2Dv6+THdyjqDL5yx08HR/tAebZcQDvKL27+EzMZpMldSUObNYX?=
 =?us-ascii?Q?fi8sZwNhGVyCy5l56gMGzY/aBEbltaWYCKdAEVLVOvbOjtxvsE3RiYsKLgIe?=
 =?us-ascii?Q?UXf2E0PLgEchUjvOWbIVgBgA+ISYW0PgAibQOt0q7g1h072vBphK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d76e37c-479e-43a1-60b5-08dede5d1680
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:27:32.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+yBwrtfVBjxCUrKC3OTg821VUezKE8WclGrlWF9QKwZawCZb4iyAqwzWclXEF6Osi8haUtjFARugLgmjrlxhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-12306-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC1B773873D

Teach dw-edma-pcie to discover a PCI endpoint DMA function from
BAR-resident metadata. The metadata supplies the DMA register window,
channel counts, descriptor windows, optional auxiliary windows, and
endpoint-local descriptor and auxiliary addresses. Accept DesignWare
eDMA unroll, HDMA compatible, and HDMA native linked-list layouts.

Endpoint-provided DMA channels use raw slave addresses because the host
programs transfers against endpoint physical addresses, not PCI BAR
addresses. The host-side dw-edma-pcie instance is remote-routed by
default, so delegated channels report completions through IMWr/MSI.

Endpoint DMA metadata currently has no static PCI ID. Let an explicit
driver_override bind use the generic endpoint DMA metadata parser, but
do not treat arbitrary dynamic IDs without driver data as endpoint DMA
devices.

The endpoint polls HOST_REQ at a low idle rate before programming DMA
window submaps and setting READY. Let the host wait for several endpoint
poll periods before treating the READY handshake as timed out.

A validation or parse failure after HOST_REQ has been raised leaves
the bit set on purpose: the endpoint keeps its submaps programmed for
a host that gave up, which is harmless, and a later re-probe rewrites
the handshake from scratch.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 401 ++++++++++++++++++++++++++++-
 1 file changed, 399 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index bb477dc0fb03..6d984b6898bf 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -11,9 +11,13 @@
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/dma/edma.h>
+#include <linux/iopoll.h>
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
+#include <linux/pci-ep-dma.h>
 #include <linux/sizes.h>
 
 #include "dw-edma-core.h"
@@ -45,6 +49,9 @@
 #define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
 #define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
+#define DW_PCIE_EP_DMA_READY_POLL_US		1000
+#define DW_PCIE_EP_DMA_READY_TIMEOUT_US		2000000
+
 #define DW_BLOCK(a, b, c) \
 	{ \
 		.bar = a, \
@@ -94,6 +101,12 @@ struct dw_edma_pcie_match_data {
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
 #define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
+struct dw_edma_pcie_ep_dma_view {
+	struct pci_dev *pdev;
+	void __iomem *base;
+	resource_size_t limit;
+};
+
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
 	.rg.bar				= BAR_0,
@@ -158,6 +171,13 @@ static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
 	.rd_ch_cnt			= 8,
 };
 
+static const struct dw_edma_pcie_data ep_dma_data = {
+	.mf				= EDMA_MF_EDMA_UNROLL,
+	.irqs				= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH,
+	.wr_ch_cnt			= EDMA_MAX_WR_CH,
+	.rd_ch_cnt			= EDMA_MAX_RD_CH,
+};
+
 static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
 					   enum pci_barno bar, off_t start_off,
 					   off_t ll_off_gap, size_t ll_size,
@@ -227,6 +247,96 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
+static const struct dw_edma_plat_ops dw_edma_pcie_raw_addr_plat_ops = {
+	.irq_vector = dw_edma_pcie_irq_vector,
+};
+
+static bool dw_edma_pcie_valid_bar(enum pci_barno bar)
+{
+	return bar >= BAR_0 && bar <= BAR_5;
+}
+
+static bool dw_edma_pcie_valid_bar_range(struct pci_dev *pdev,
+					 enum pci_barno bar, u64 off,
+					 size_t sz)
+{
+	resource_size_t bar_len;
+
+	if (!dw_edma_pcie_valid_bar(bar) || !sz)
+		return false;
+
+	bar_len = pci_resource_len(pdev, bar);
+
+	return off <= bar_len && sz <= bar_len - off;
+}
+
+static bool dw_edma_pcie_valid_block(struct pci_dev *pdev,
+				     const struct dw_edma_block *block)
+{
+	return dw_edma_pcie_valid_bar_range(pdev, block->bar, block->off,
+					    block->sz);
+}
+
+static bool dw_edma_pcie_ep_dma_bar_scannable(struct pci_dev *pdev,
+					      enum pci_barno bar)
+{
+	unsigned long flags = pci_resource_flags(pdev, bar);
+
+	if (!(flags & IORESOURCE_MEM))
+		return false;
+
+	if (flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+		return false;
+
+	return pci_resource_len(pdev, bar) >= PCI_EP_DMA_METADATA_HDR_LEN;
+}
+
+static u32 dw_edma_pcie_ep_dma_readl(struct dw_edma_pcie_ep_dma_view *view,
+				     u16 off)
+{
+	return readl(view->base + off);
+}
+
+static void dw_edma_pcie_ep_dma_writel(struct dw_edma_pcie_ep_dma_view *view,
+				       u16 off, u32 val)
+{
+	writel(val, view->base + off);
+}
+
+static void
+dw_edma_pcie_ep_dma_clear_host_req(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 ctrl;
+
+	ctrl = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	ctrl &= ~PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+	dw_edma_pcie_ep_dma_writel(view, PCI_EP_DMA_METADATA_CTRL, ctrl);
+}
+
+static u64 dw_edma_pcie_ep_dma_read64(struct dw_edma_pcie_ep_dma_view *view,
+				      u16 lo, u16 hi)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, hi);
+
+	return (val << 32) | dw_edma_pcie_ep_dma_readl(view, lo);
+}
+
+static int dw_edma_pcie_ep_dma_read_off(struct dw_edma_pcie_ep_dma_view *view,
+					u16 lo, u16 hi, off_t *off)
+{
+	u64 val;
+
+	val = dw_edma_pcie_ep_dma_read64(view, lo, hi);
+	if (val > type_max(*off))
+		return -EINVAL;
+
+	*off = val;
+
+	return 0;
+}
+
 static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
 					       struct dw_edma_pcie_data *pdata)
 {
@@ -328,6 +438,273 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static int
+dw_edma_pcie_parse_ep_dma_ch_table(struct dw_edma_pcie_ep_dma_view *view,
+				   struct dw_edma_pcie_data *pdata,
+				   u16 table_off, u16 entry_size, u16 ch_cnt,
+				   bool write)
+{
+	struct dw_edma_block *desc_blocks = write ? pdata->ll_wr : pdata->ll_rd;
+	struct dw_edma_block *data_blocks = write ? pdata->dt_wr : pdata->dt_rd;
+	u32 ctrl;
+	u16 i;
+	int ret;
+
+	for (i = 0; i < ch_cnt; i++) {
+		struct dw_edma_block *desc_block = &desc_blocks[i];
+		struct dw_edma_block *data_block = &data_blocks[i];
+		u16 off = table_off + i * entry_size;
+		u16 field, lo, hi;
+
+		field = off + PCI_EP_DMA_METADATA_CH_CTRL;
+		ctrl = dw_edma_pcie_ep_dma_readl(view, field);
+		if (FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_HW_CH, ctrl) != i)
+			return -EOPNOTSUPP;
+
+		desc_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_DESC_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &desc_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_DESC_SIZE;
+		desc_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_DESC_ADDR_HI;
+		desc_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		desc_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, desc_block))
+			return -EINVAL;
+
+		*data_block = (struct dw_edma_block) { .bar = NO_BAR };
+		if (!(ctrl & PCI_EP_DMA_METADATA_CH_CTRL_AUX_VALID))
+			continue;
+
+		data_block->bar =
+			FIELD_GET(PCI_EP_DMA_METADATA_CH_CTRL_AUX_BAR, ctrl);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_OFF_HI;
+		ret = dw_edma_pcie_ep_dma_read_off(view, lo, hi,
+						   &data_block->off);
+		if (ret)
+			return ret;
+		field = off + PCI_EP_DMA_METADATA_CH_AUX_SIZE;
+		data_block->sz = dw_edma_pcie_ep_dma_readl(view, field);
+		lo = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_LO;
+		hi = off + PCI_EP_DMA_METADATA_CH_AUX_ADDR_HI;
+		data_block->paddr =
+			dw_edma_pcie_ep_dma_read64(view, lo, hi);
+		data_block->paddr_valid = true;
+		if (!dw_edma_pcie_valid_block(view->pdev, data_block))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_ep_dma_wait_ready(struct dw_edma_pcie_ep_dma_view *view)
+{
+	u32 val;
+
+	/*
+	 * The host cannot build a usable eDMA instance until the endpoint has
+	 * pinned and published the channel submaps, so keep the handshake
+	 * synchronous and bounded during probe.
+	 */
+	return read_poll_timeout(dw_edma_pcie_ep_dma_readl, val,
+				 val & PCI_EP_DMA_METADATA_CTRL_READY,
+				 DW_PCIE_EP_DMA_READY_POLL_US,
+				 DW_PCIE_EP_DMA_READY_TIMEOUT_US, false,
+				 view, PCI_EP_DMA_METADATA_CTRL);
+}
+
+static int
+dw_edma_pcie_validate_ep_dma_metadata(struct dw_edma_pcie_ep_dma_view *view,
+				      u32 *metadata_ctrl, u8 *reg_layout_data)
+{
+	size_t table_size, table_end;
+	enum pci_barno reg_bar;
+	u16 len, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	u8 layout, layout_data;
+	u32 val;
+
+	val = dw_edma_pcie_ep_dma_readl(view, 0);
+	if (val != PCI_EP_DMA_METADATA_MAGIC)
+		return -ENODEV;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_HDR);
+	if (FIELD_GET(PCI_EP_DMA_METADATA_HDR_REV, val) !=
+	    PCI_EP_DMA_METADATA_REV)
+		return -EINVAL;
+
+	len = FIELD_GET(PCI_EP_DMA_METADATA_HDR_LEN_FIELD, val);
+	if (len < PCI_EP_DMA_METADATA_HDR_LEN)
+		return -EINVAL;
+	if (len > view->limit)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_LAYOUT);
+	layout = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_ID, val);
+	if (layout != PCI_EP_DMA_METADATA_REG_LAYOUT_DW_EDMA)
+		return -EOPNOTSUPP;
+
+	layout_data = FIELD_GET(PCI_EP_DMA_METADATA_REG_LAYOUT_DATA, val);
+	if (layout_data == EDMA_MF_EDMA_LEGACY)
+		return -EOPNOTSUPP;
+	if (layout_data != EDMA_MF_EDMA_UNROLL &&
+	    layout_data != EDMA_MF_HDMA_COMPAT &&
+	    layout_data != EDMA_MF_HDMA_NATIVE)
+		return -EINVAL;
+
+	val = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_CTRL);
+	reg_bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, val);
+	if (!dw_edma_pcie_valid_bar(reg_bar))
+		return -EINVAL;
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, val);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, val);
+	if (!wr_ch_cnt && !rd_ch_cnt)
+		return -EINVAL;
+	if (wr_ch_cnt > EDMA_MAX_WR_CH || rd_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, val);
+	if (entry_size < PCI_EP_DMA_METADATA_CH_ENTRY_SIZE ||
+	    entry_size % sizeof(u32))
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)(wr_ch_cnt + rd_ch_cnt),
+			       (size_t)entry_size, &table_size) ||
+	    check_add_overflow((size_t)PCI_EP_DMA_METADATA_HDR_LEN,
+			       table_size, &table_end) ||
+	    table_end > len)
+		return -EINVAL;
+
+	if (metadata_ctrl)
+		*metadata_ctrl = val;
+	if (reg_layout_data)
+		*reg_layout_data = layout_data;
+
+	return 0;
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_data(struct dw_edma_pcie_ep_dma_view *view,
+			       struct dw_edma_pcie_data *pdata)
+{
+	u32 ctrl, reg_sz;
+	u8 reg_layout_data;
+	u64 reg_off;
+	u16 wr_table, rd_table, entry_size;
+	u16 wr_ch_cnt, rd_ch_cnt;
+	int ret;
+
+	ret = dw_edma_pcie_validate_ep_dma_metadata(view, &ctrl,
+						    &reg_layout_data);
+	if (ret)
+		return ret;
+
+	pci_dbg(view->pdev, "Detected PCI endpoint DMA BAR metadata\n");
+
+	pdata->mf = reg_layout_data;
+	pdata->rg.bar = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_REG_BAR, ctrl);
+
+	wr_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_WR_CH_COUNT, ctrl);
+	rd_ch_cnt = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_RD_CH_COUNT, ctrl);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt, wr_ch_cnt);
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt, rd_ch_cnt);
+	pdata->irqs = pdata->wr_ch_cnt + pdata->rd_ch_cnt;
+	reg_off = dw_edma_pcie_ep_dma_read64(view,
+					     PCI_EP_DMA_METADATA_REG_OFF_LO,
+					     PCI_EP_DMA_METADATA_REG_OFF_HI);
+	reg_sz = dw_edma_pcie_ep_dma_readl(view, PCI_EP_DMA_METADATA_REG_SIZE);
+	if (reg_off > type_max(pdata->rg.off) ||
+	    !dw_edma_pcie_valid_bar_range(view->pdev, pdata->rg.bar,
+					  reg_off, reg_sz))
+		return -EINVAL;
+	pdata->rg.off = reg_off;
+	pdata->rg.sz = reg_sz;
+
+	entry_size = FIELD_GET(PCI_EP_DMA_METADATA_CTRL_CH_ENTRY_SIZE, ctrl);
+	wr_table = PCI_EP_DMA_METADATA_HDR_LEN;
+	rd_table = PCI_EP_DMA_METADATA_HDR_LEN + wr_ch_cnt * entry_size;
+
+	ret = dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, wr_table,
+						 entry_size, pdata->wr_ch_cnt,
+						 true);
+	if (ret)
+		return ret;
+
+	return dw_edma_pcie_parse_ep_dma_ch_table(view, pdata, rd_table,
+						  entry_size,
+						  pdata->rd_ch_cnt, false);
+}
+
+static int
+dw_edma_pcie_parse_ep_dma_caps(struct pci_dev *pdev,
+			       struct dw_edma_pcie_data *pdata)
+{
+	struct dw_edma_pcie_ep_dma_view metadata_view;
+	void __iomem *base;
+	resource_size_t bar_len;
+	enum pci_barno bar;
+	u32 ctrl;
+	int ret;
+
+	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (!dw_edma_pcie_ep_dma_bar_scannable(pdev, bar))
+			continue;
+
+		bar_len = pci_resource_len(pdev, bar);
+		base = pci_iomap_range(pdev, bar, 0, 0);
+		if (!base)
+			continue;
+
+		metadata_view = (struct dw_edma_pcie_ep_dma_view) {
+			.pdev = pdev,
+			.base = base,
+			.limit = bar_len,
+		};
+		ret = dw_edma_pcie_validate_ep_dma_metadata(&metadata_view,
+							    NULL, NULL);
+		if (ret == -ENODEV) {
+			pci_iounmap(metadata_view.pdev, base);
+			continue;
+		}
+		if (ret) {
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ctrl = dw_edma_pcie_ep_dma_readl(&metadata_view,
+						 PCI_EP_DMA_METADATA_CTRL);
+		ctrl |= PCI_EP_DMA_METADATA_CTRL_HOST_REQ;
+		dw_edma_pcie_ep_dma_writel(&metadata_view,
+					   PCI_EP_DMA_METADATA_CTRL, ctrl);
+
+		ret = dw_edma_pcie_ep_dma_wait_ready(&metadata_view);
+		if (ret) {
+			dw_edma_pcie_ep_dma_clear_host_req(&metadata_view);
+			pci_iounmap(metadata_view.pdev, base);
+			return ret;
+		}
+
+		ret = dw_edma_pcie_parse_ep_dma_data(&metadata_view, pdata);
+		if (ret)
+			dw_edma_pcie_ep_dma_clear_host_req(&metadata_view);
+		pci_iounmap(metadata_view.pdev, base);
+
+		return ret;
+	}
+
+	return -ENODEV;
+}
+
 static int
 dw_edma_pcie_parse_synopsys_caps(struct pci_dev *pdev,
 				 struct dw_edma_pcie_data *pdata)
@@ -367,6 +744,14 @@ dw_edma_pcie_parse_xilinx_caps(struct pci_dev *pdev,
 	return 0;
 }
 
+static const struct dw_edma_pcie_match_data ep_dma_match_data = {
+	.data = &ep_dma_data,
+	.plat_ops = &dw_edma_pcie_raw_addr_plat_ops,
+	.parse_caps = dw_edma_pcie_parse_ep_dma_caps,
+	.flags = DW_EDMA_PCIE_F_REG_OFFSET,
+	.chip_flags = DW_EDMA_CHIP_PARTIAL,
+};
+
 static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 				 const struct dw_edma_pcie_match_data *match,
 				 struct dw_edma_pcie_data *pdata,
@@ -400,8 +785,17 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
-	if (!match)
-		return -ENODEV;
+	if (!match) {
+		/*
+		 * The endpoint DMA metadata path has no static PCI ID yet.
+		 * Accept it only for an explicit driver_override bind, not for
+		 * arbitrary dynamic IDs without driver data.
+		 */
+		if (!device_has_driver_override(&pdev->dev))
+			return -ENODEV;
+
+		match = &ep_dma_match_data;
+	}
 	pdata = match->data;
 
 	if (!pdata)
@@ -659,6 +1053,9 @@ static struct pci_driver dw_edma_pcie_driver = {
 	.id_table	= dw_edma_pcie_id_table,
 	.probe		= dw_edma_pcie_probe,
 	.remove		= dw_edma_pcie_remove,
+	.driver		= {
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 module_pci_driver(dw_edma_pcie_driver);
-- 
2.51.0



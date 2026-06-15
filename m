Return-Path: <dmaengine+bounces-11542-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LYh1Dp9GMGr8QgUAu9opvQ
	(envelope-from <dmaengine+bounces-11542-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:38:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8757F6893C6
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:38:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=S4ikaIZ6;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11542-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11542-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B1833016EE8
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 18:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4B34EF1C;
	Mon, 15 Jun 2026 18:37:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27612DEA94;
	Mon, 15 Jun 2026 18:37:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548644; cv=fail; b=GEfVAWHvbjAZhn/D/+GepTOFjaY1cQO8njAQZuh04zYR+va6/ds83fhSMTkFr8otQIu2OfU8nTm8FUxPLYMJVVa/CDfPinHnMehxnppdNjajHSLQEX1DN8FvBjARBmPNiHwfu4K6/Cc3Dn5hAsAdp+9FmAD2K+2tE9klczE5OqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548644; c=relaxed/simple;
	bh=RitZPH9O+YjD4bWEcKhHVNVlwHXnXWDfZq1XvKNF7QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AGzwfXrOYq7si2KsXtFD6ZdawphnVFRYhZuaxMwhVtIFUq53LyGzjlIWWF+PaeT/OfkazNuNhcarDLb8qN7bfU6V4uhLYGbdUcJENGcHHa1HQiDUfIkqk3BaJuoPUjakuklGYcZU6ie/Xy+Ci+m6yTPKAk9OYeylJobFh3xFHNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S4ikaIZ6; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8p8Zz4g9jZjVA7IimGNZw3K3LLaVMAYD4rhAR+BqI92x1Ax95btdJGZNUrr0AyxImAtZZAhlDZa5filsyI1EQl/fcpCZQ87FrPgm09p78HCI1JnnEvw+X2JFubV82ldF+2IFqJuKuZdA0TltCP3y/8nraDUgc2O7QvA2JHiBJMLxPYjXGnu/yYqUorOvLe3/kb9RVrTckypHqKmys7RtzeDzx8+9+EyTeRApNGHG37IeAa9AR8o5hBmRImTl3k2KvBJ3UuN0mNMko/vlDLsQVrQdLUrYRdRJnNjEXYRzFpScLP8aZTRXgiXFLy+1TNQLPEZiylnRl5E0o9M1FmX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfKOpPpK6dzNb1/gcbVKtf0gV/8j8lohzSidlLoDiZo=;
 b=kHxe+GCJiyOtjUBkpxh/hSVuNv2RLn2aAyXKOcxcEQT1nXjJX4IyUTZ6UWs8zdd0r7a6XThv47lLKsoUyFd22/aK3jEZXHCJd1yg60aBYe+yc9k8+qIW64oof3/gVYaOUixjvBfcwg9pAZFUenmuH0EU25BRylflJLOoB4oNmKE3laqfTDsHJhACUw13RE+behc/UGlEuujjA4kUSJ7094M3cKmO0K+XIbXKoazc3HadzZfceh0s7OV324ugXqEf138Qc4E/ILW1zJGQCL6gihcx/WymTDG6CKNV+BJov+WiDEFtzz1Fd9m021iAh52V7+gtc1Fl6E7QZAhZ/zNgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfKOpPpK6dzNb1/gcbVKtf0gV/8j8lohzSidlLoDiZo=;
 b=S4ikaIZ6/C5EUi8GRQ1to21fdVR+NhEwSKLFKxsbEoEim4AkblF72oC9sF7BYCpERxRWMZcBeNCprAFmr5OdDlRmef/ISi1kT5JPA23bbNloGA8bT9ws8QARZVI6hNQpXJ2RFkxEfnNueHH2eoZ1wLDNWiNgVhLksZnQGF1PxrbfklfWgp/CCdLrIOhskVc8Aghot35xQeqb7nsHjx2ubX2N2e0yWkLSRKm1kNyV68Wf2fvYS8nEjsneHOPvis1MhvYRpQKBCCLYwy3PnaLlJYrqLWyLUd5pSupJXjqcxPUn3MX/U76rY78s2tjtYeDIqxMdl4DdQHDGqLQrmnRxxg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 18:37:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:37:19 +0000
Date: Mon, 15 Jun 2026 13:37:06 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] dmaengine: dw-edma: Terminate STOP requests
 without callbacks
Message-ID: <ajBGUuooEoaFSWfS@SMW015318>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-4-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: 18499d19-195f-4802-3481-08decb0d21a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|19092799006|1800799024|56012099006|11063799006|6133799003|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aoVvP3T5xZJ+byi33i6U/xlhi6uhcIzZyZkzBUHNdplygs7oaR33OjrU8V1GdyWU4FcpT6SvX5AQzeKyGwpmECNE0MVP34vqJFhcDZxAMf03A2s12SunTUHsVAWe+9eDL3a/NbuKOBuvQrkO0f1IUf1kH3m9KtkRXLRdNZFuP6QK2QJmO7Se9twtHfdP69U8byceXhxQVgGA4VHHs0LiSRgn8JFqEf83sxImNkmlHqCuqVRLB8w06PH1s9vzLbIEYHbnYf2qGxSG/9j6HhGk92NOP8oHi1rrz7be4Peh4WA5UCptHrsLzpL7g6Cexls98/TRHWwv8/hArd1DK7W8ajDWRblq9Mg1icTSe1BWTyOHAXC0Q8BKezSlrOyNI7EK4jYBgaMH3GLCihNMDpgo877pkjYKDDqygeQBOaqemtf22aEpCFWn/VqXP7BmzKur3BYrhAXZhQPX0MMzSfQ7UyXJoy2nNry6keUCiD1dr6OIE1TrD2ibm6JCQU0zWqvhpEIjJnksadOItHzWJxdeGL0VGZ8Gn55UgmMNakKkhai+S2q6lHPGVt94MLr19SxPC/TUVH2TUxA7h9ijmryE4EoKyKAc8eY0YyEvNRFsqmEVd+my1nkdqq9pxd9OvGNjKXB2fsTDL43rn5hAy3QVYdnBs/M74BzW93al5/SUbFBML44UA87Zgchip8k7zhzM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(19092799006)(1800799024)(56012099006)(11063799006)(6133799003)(5023799004)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwhBp6/P6R2RSubOHAijGu4G0O8vxboPCl1HnYC7fERXjxpL8tcmGvXNUXry?=
 =?us-ascii?Q?KAoallBhp+hLt7UZgcOfMT5FkVuKpFw23F4i0Gaj1PB2jAL3BoXpYRQzctCx?=
 =?us-ascii?Q?LNbE9mKe99dheSHm7wI9/ztxp4bXr2u2M9347zT6DXITUB6A51YAZTjNCo+h?=
 =?us-ascii?Q?btvRp94MTJUwe1ddykk9ME8A551sQZ4ctxDOyuaFz09dlWlTsxYOWUkX59ay?=
 =?us-ascii?Q?YfCGQG58N8P1pqYdCFoVhSV96K/0rBplnwfPYAVmL/m6URA2ZSKDlmSq2She?=
 =?us-ascii?Q?ODAY3WqXxosVK74FlDFYf8WWXg/8P7h+yhU1ZWmzysgwMHuNA5eyvIWkagMb?=
 =?us-ascii?Q?/YvHFwiSZAPB33mo+C8ivPQRxaZ/uS5EBgww2ELjNHlRHn1FMEVubQrj2sMK?=
 =?us-ascii?Q?Xx/NfS56Pgl3AkHTMNP9bwZNdPz3KbWtKxcJYSUk6vzZuJ64JXMVKN2zEDR1?=
 =?us-ascii?Q?IIDq9erW0++O4vA8/wSXZB33RlLtsTAwsbAjy+pC47Ag6CCBYp1t/ql3x/DE?=
 =?us-ascii?Q?KXtTDElpvF6P/aSenL13nNBN3FW62tjw/iUxrZadou9d0t4OpbW1v1+uHS+M?=
 =?us-ascii?Q?jq+1QKaq2ALUHpMI9A1ducdaakuvf/NqgALJryCHyHnphaytl6agk5Eqodft?=
 =?us-ascii?Q?m6vKH+NGHnGbDUWplCowxPgtw+G+8PwUSEX6yDWzptT83YfGV8NZpe2WIKUY?=
 =?us-ascii?Q?6sQUT8sUPN6YpQq2xjp0sKlBnddnH5iQa761ACbTDhAjMGzmCC5910+bhQo8?=
 =?us-ascii?Q?H1lI8LzGmLOfd0GthziZh16kep3q83CGF1Rs5esZLE2Fln5zweSTpKGXaMlT?=
 =?us-ascii?Q?bZ6MWFfTPPmpunM+VeWs03QI1BZFbxxrwB01ayWGZGjjE7XRFwPAYlY1+EWi?=
 =?us-ascii?Q?aLOyfHV7PM8i9jYNwxuoBoKwgymGCv4Ff0TfzsrK6tqgdzdpf3eh4sqf9IT3?=
 =?us-ascii?Q?ux9bEJafyLh8mp5BYFo0gci1+FUF9NpHqZuOAkPb5El3aAQdK/4Z53JCcdO/?=
 =?us-ascii?Q?AUzP/MSKHWtbBBnXIWwCc6YhWkHSy0EloXJ9jAIo8UVjhesDu3LL40RQJbKy?=
 =?us-ascii?Q?qeqyj8iXsaf8CVXCj50F8g9hOjr5Wd9R1iTkurEGoSmbLN6fW9LX5Y8n7P1c?=
 =?us-ascii?Q?pRRgRbU9khbghv2udGVwXIkA815H4TgT+zq7zLLFcvOohXmzvaWkJts3Qzn4?=
 =?us-ascii?Q?te/Jqep8+IvUkVUrHHEdS1oSFkZ3b5tJErEYIHCXG4I4W+6qVRx2ELOso03Z?=
 =?us-ascii?Q?izZa8EHrAqsiA5G1tAhfEXhnKlxDbpL++N7qvXTelFlpSAG7yAHz8tJnwLor?=
 =?us-ascii?Q?aVaT+mX0btL95NbKgQ4mK754fy70EqRZu+cTel9Kdosu8b1hsdwMGKel1F66?=
 =?us-ascii?Q?Db/syFKMNwAFAcLXQVlPMk4kaSXmf5yCTl19fBk0/rPFF9vDtU83elwy4L1G?=
 =?us-ascii?Q?bga2jOJKxDAN2hxSddtQBeM6mgugScFEH/iEkJbdrpxquCl7JyzXOwEz3Ah1?=
 =?us-ascii?Q?i4OIbzo15sl4oe46fGr3KudyIxahQbNT88PjizD0DSPVNDXXi8Gv3cSj0Kx1?=
 =?us-ascii?Q?ElXE/omyEM8dr82LfOIxIrvjsbeVfp2wp+R13F5QrVzKdhKPqMujL3qszYrf?=
 =?us-ascii?Q?7ZRmdse20D913Vzz3B2stIBmUC5R/KpOTa9j9IxtzaCPKuuYpnPGGb+275w3?=
 =?us-ascii?Q?eCSZI/e0vFBBBM+jAoI+ZG/U0MaUqKvU4Jj4yuXjTFOpbC/ft/iUpbGwEhTh?=
 =?us-ascii?Q?O1ZmavxiWcx20HFI/a+TPzBC7cb40s3hKdhylRwgCAvMg3E6AbS2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18499d19-195f-4802-3481-08decb0d21a4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:37:19.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKdW2TBmr7N/ZzLcbpZRdDEa8DNCR88xxQkIXK0caM1zvYGyx5sDrd2H66/XL+SL9L18rlirhx85kbct7Gh7pdjEqdnM5dIQUVXRo6q63ataQF0Mq4nsNFqRlci46AKb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11542-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,SMW015318:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8757F6893C6

On Tue, Jun 16, 2026 at 12:40:57AM +0900, Koichiro Den wrote:
> The STOP request path handles device_terminate_all(). The DMA Engine
> client documentation says in the "Terminate APIs" section of
> Documentation/driver-api/dmaengine/client.rst:
>
>   "No callback functions will be called for any incomplete transfers."
>
> dw-edma used vchan_cookie_complete() for a stopped descriptor. This
> queues the descriptor on the completed list and schedules its callback.
> A late callback after dmaengine_terminate_sync() can dereference
> callback state, such as a request object, that the client has already
> freed.
>
> Move stopped descriptors to the terminated list. Complete the cookie
> before doing so, so cookie polling observes that the transfer is no
> longer in flight, but do not schedule the completion callback. Add a
> synchronize callback so virt-dma can release terminated descriptors.
>
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index d99b6256660a..bedaee6d30ab 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -106,6 +106,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
>  	return 1;
>  }
>
> +static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
> +{
> +	list_del(&vd->node);
> +	dma_cookie_complete(&vd->tx);
> +	vchan_terminate_vdesc(vd);

Is it vchan_terminate_vdesc() missing call dma_cookie_complete()?

> +}
> +
>  static void dw_edma_device_caps(struct dma_chan *dchan,
>  				struct dma_slave_caps *caps)
>  {
> @@ -537,8 +544,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
>  			break;
>
>  		case EDMA_REQ_STOP:
> -			list_del(&vd->node);
> -			vchan_cookie_complete(vd);
> +			dw_edma_terminate_vdesc(vd);
>  			chan->request = EDMA_REQ_NONE;
>  			chan->status = EDMA_ST_IDLE;
>  			break;
> @@ -610,6 +616,13 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
>  	return 0;
>  }
>
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	vchan_synchronize(&chan->vc);
> +}
> +
>  static void dw_edma_free_chan_resources(struct dma_chan *dchan)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> @@ -723,6 +736,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  	dma->device_pause = dw_edma_device_pause;
>  	dma->device_resume = dw_edma_device_resume;
>  	dma->device_terminate_all = dw_edma_device_terminate_all;
> +	dma->device_synchronize = dw_edma_device_synchronize;

Can we provide generally call back like, vchan_synchroniz_dmachan(), or
change existing vchan_synchronize() to by using struct dma_chan *dchan.

avoid duplicate it every dmaegine drivers.

Frank

>  	dma->device_issue_pending = dw_edma_device_issue_pending;
>  	dma->device_tx_status = dw_edma_device_tx_status;
>  	dma->device_prep_slave_sg_config = dw_edma_device_prep_slave_sg_config;
> --
> 2.51.0
>


Return-Path: <dmaengine+bounces-11753-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aMqvEiCKOmqD/QcAu9opvQ
	(envelope-from <dmaengine+bounces-11753-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 15:29:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9196B773B
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 15:29:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ibxvuruD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11753-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11753-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA31305A475
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F731F9B9;
	Tue, 23 Jun 2026 13:29:01 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375772C0F7F;
	Tue, 23 Jun 2026 13:28:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782221340; cv=fail; b=OLYkQTlBQoCSo7On5r7rUuQxWXWGVsyqzjsZvCGzdlQs+UpV4MUwsW5IUe0AgVtlBbXg/2aKupVWCja6bTbwZm/oH/SF7Pq8MtGHORvlXAT5gd+2bAuGeKQ7mQg72UP1CSPEICwpDbDz8VEe4RWJMO0kY6miBgb/9VgNPYtzyHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782221340; c=relaxed/simple;
	bh=rcz8w1ETQXcaolbCFX5+/btxvNmmMeXui4hRUlccB74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJncvHLir5RDjs1hGdRZ/qEzGTJDbqDXjsx05ycEVYeCVUDT6w8kCmiPxBAPjpW6dDAW8VJsSA3IiUYx8LhIKtVXgwP+6eq7q5OE7kenKsosJf74UvLiIAQmevHNaqAytSIxp7GebAmu8weYtx6lqUe2cT5ur7zMWGCFlWo1cUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ibxvuruD reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqAgxx2bSk1tX73nLFjABFXH0N684Rk7GGHLlxl2OtuW/eKw2en5wORQ6eprByvwuXLi7PQM+aS8axtgAj6LdyApfZ1Lc+pzl/RB4p5o4f9/pxaQIz+Mvt+6F0RXvw0FZ2Fak7AMlQlL67+tHVVsgOhePkOm+FgHwq8k0jg35xrrODR2YtXCpa4LhapflQty8zT5qGpKWbLvH0cWREA+qwt2SeW45pBeoPO3wdjLV7WGhYQU4e0OTdx+6I/vgZakUcZEViJ5GfMN1d6x+YlwX7+Gc49YcAtqmiuhRsjc9pJcl9gCEspw4+CD5mhoIJ+vrR9r8e+Ev9Y/H+Am896EnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okXdtSnPwGGJgXtSgcgSM+javHp2kXUoBVYY9BqqpSA=;
 b=pOcGsjTjCbp0rD0mwCohWCElsfP2nyxmpbVs/usM7Xw1X4hFrakdheIgDGGn8d/2tJBnSNZLlWCxT2VP1vm2rbHcD0pUIBWVtoA73x18sbPGT9RHHlBJQPQdz2MNEV63gdF3R/xgXp3dMza/kvwwdHYfihfHStbKLVaMIpwQLatdVFatA0DnuqcSMkzbFJ63kvL316mLyZQaNShB5ZJjN4VwuuI+0TrbnYW8P/5XkzoTx4kx5zHMFy9N++fqjIFLNB71n17kHGJ0dOj/tgmOXKmrvsGPepA1QmE/yvMA/GyC3rfKKHNX+CwbX3Pfpw9Wid56/UYsZbx6WnhL6Q0sFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okXdtSnPwGGJgXtSgcgSM+javHp2kXUoBVYY9BqqpSA=;
 b=ibxvuruDdPWQ+3geNk8wCWZrrydtTqyz3uUdtC6BOyHmUZaBx+umdfx/ztHAeQsKXCfilfrPcJyWWvLfTjibZ3iEVZWwUG30A5+kUzOKaMW68nynvUOr9g1Kv4udMPVFDixNpV4l3v/iasAQdhVguqNYHkpztVuYvx768m1qSqzc29duYETz0f3QYZQE0FXL7Wgqhgz4ARJ1weQHA3hA9fYMSqPLYBWCLG9Yg+k2vabMXVAzjgsxvGE6fsJKVQMr9ooV1EuSno0IxDc8c+cKnE2Laa5rR9qgC+Dxg0TWYNWMFUSD2+AhygKzAbLGipQrHxY3KLE2stcVnMrGgRHqmw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8913.eurprd04.prod.outlook.com (2603:10a6:20b:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 13:28:56 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 13:28:55 +0000
Date: Tue, 23 Jun 2026 08:28:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajqKD0BdQY5kSZjh@SMW015318>
References: <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpWzimx-5jlczpp@ashevche-desk.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpWzimx-5jlczpp@ashevche-desk.local>
X-ClientProxiedBy: SN7PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:806:f3::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: babfb87e-4c44-4aa1-5a7c-08ded12b5fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|19092799006|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LEJp4ybkaf05e0v2J36Ht/80srMHQNTxPhHewv7USbhlEp89008gyHcwgl3x5EJ7YJanT89J4NgcdvXywyElZZXIgkEMNK2fKcl98ZMJEO/gz1pcYTs0BBzMPiU7RJiRt0zD1OsnyjjhJ1TfGMBosMhJ5qDH6FaLFqaF2DEDfVNXfsTVXH5CZl9O2hEtzQAie5gKQege818Ab0ovYiELOglxCjbjsTjA2wPEa15Ug99Um4lJNnRBfSkX2WwBLIEdPpXzIXnnL8Wr5TFhTFYJV8Ro3qyO7gtoNwMKq9anfxQt/li17frRkLFUGgcxzxsVuCy8UTcUQST6ewXbZSQwHFoM7Z61mSwy6TtPEVwC1Yea8JgsFmXmb1BjzWR5+NDHwRmAceI3/j7aAW+zUOXpha8CieSuCAOws+N4sIs2WN1hsjKC7frvN08N/C8QgsuMmvM0NHi5kuyBw2CTU4Gze/EBiVZRKEpiPxereiXzKISCdB9/+MIhwegQKi8skPfmCJ8Bz++W3W/jNTO7c/wS5DbBnE/phn13zctF7sXg4PIZd0medGsplmRrideZbPsTGP8QPgCTCR8OxcYibWuzGGk5StuaIgZF0glIsUz0OupsZp11KCzOeDAxJL0j9A1y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(19092799006)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?DCbWdDSE5/eeAZ2a4MfEfoo/NvJiFZjh21jstZ2unwvHPfeybVhqrrF4nS?=
 =?iso-8859-1?Q?NO9mezCaqxQw1C2kEPWUzPOXg/cDb0Gg48XoLjNzhG7dk+tt3GggcRPr9r?=
 =?iso-8859-1?Q?3q2l/vPUTZIhyDmbPBBZxLC8LmOB/f695lDEa0AlOhTmIoNDZy4/jdqWAd?=
 =?iso-8859-1?Q?z3Zkfk60TXGxt9xKnMeBmVUQtKzM6obPmJBR5THxIBOwuKUxfYRBwrvr23?=
 =?iso-8859-1?Q?JQhJ1vzrkeioUU2YNRPFsYtlbK1ffDXFUOYwLu6kcm0GZzXamSwmMol5lM?=
 =?iso-8859-1?Q?kl7GiEaO6YCKFJKID3/nAe6CV1sUwzgi6VG2wguw0MrG1faeHARqwxOOlZ?=
 =?iso-8859-1?Q?OGSX2qBJMokvwholaGmVO00AVi9JQBv8XAf0r/pW9cnl5nEP2GGw2y36sm?=
 =?iso-8859-1?Q?eMJsCiKnhlE5Ye5pqYu6jUGGQM5nh6GzSTBqFqyykBUzkATNXcnAxy63+w?=
 =?iso-8859-1?Q?U+MHsa2WmiLOmXmkhHaKGBHxlVNWUYEtyF99EG80s/NF/7rZFvZWfzbY06?=
 =?iso-8859-1?Q?2Ee98TIMIX+Sdudvz3vOB0d+RgL+0IwztGSNbJrJ+0Qz1mh0+bMq2PgMoz?=
 =?iso-8859-1?Q?SasVqqfdGP4j3y08jnR5C0j2gtnDT04uou98cFB18aUCbaZ63HbUFVO5Sf?=
 =?iso-8859-1?Q?jSVpXiYNIATPWceB9GYpyuQCoV0RBByPfUT5a/nKAogkCjHN++u4s332UV?=
 =?iso-8859-1?Q?21O3OX9ARz3mQaTP3apsITuHW3inlnEgC88qiSbmsR0VD9BDBc75zXyLlZ?=
 =?iso-8859-1?Q?cxAhxf8xp5fjRVi8f+xz2bo9E5yynj+x+OYXIwxhGeflC/sTK6Up/Ac28+?=
 =?iso-8859-1?Q?dza/y7kTHa5hS12RV5jo4qSYv3FBKa+x9oMIUuVLKOlS3wz2eWdr7o2H13?=
 =?iso-8859-1?Q?7OtdYHBXf5k0m/uCQqlVr227jj4hG5PH3zww1LIEanxJMeBWGEl+DbVhoB?=
 =?iso-8859-1?Q?I0DuaRP2cfP9SR7lUjJQAOGtZu1qw62ZjFgtCpYVtiaWbOxhsJEO/9htWi?=
 =?iso-8859-1?Q?OPLKNmoZZyWtlT4nBmuhTOiMm2juInN96sxPQFhgDM2WRsARPVfynWgUK3?=
 =?iso-8859-1?Q?GPwpkkAHP+jHGusjzrxdXuCQvnAtsRbSaK6NeMmqCZfn3/vC0FIQdT46Gc?=
 =?iso-8859-1?Q?DDF9W+eoPgVXq6Fd0HAhcOk4Sv0ghpEFo3BLzjh8kbmY0NzDoVfthJhVef?=
 =?iso-8859-1?Q?oThRR0B3inuOaOpaWEI7BLjBjYNjzIu3Tl9HazJZ3hKeaSg/XHKt+C59cg?=
 =?iso-8859-1?Q?wCmKHTgw+g2rq8X+0jMUc9200rJ+LqCHfYaglBf0z/LhBTd4zZn8hwR+g3?=
 =?iso-8859-1?Q?3WmQehb5QScEQrSDY0YzHCJDrlaqyPw1fDZNJw1OMvndqfj8pkZV1/ylQg?=
 =?iso-8859-1?Q?KXPr4fEJxf/fLBQnG2gduacpCpHoXryAqeefKVlzHc3ftvziRoubKzpoCh?=
 =?iso-8859-1?Q?+5xQd4xUUD726W+1i3i+HlXCUaGR4qtcr1fhsANVXxiN3P9dsB9xPnEz1H?=
 =?iso-8859-1?Q?P9xkcMUKnssq25ko4tfGdnkHAQPCkXQUM8VjxXOtAJYIoeZl+WiAENZUjH?=
 =?iso-8859-1?Q?053hMoqT7mau5lOV0fRWfy09DzHwMBTMocmYWbJIywU3umfINjE+0BRU+e?=
 =?iso-8859-1?Q?sVp7a9RN/x20BQ1d8mrbIvuZKvTKsAaQlaXBfyhUvTuuGJRmTL5JSm04M4?=
 =?iso-8859-1?Q?VwEsyuaFc0BTjfkfctf+C5FlOTGnv6QcZUvZU6145QeuKnSC9K37o/c9N2?=
 =?iso-8859-1?Q?1bbjJWf0d3LraBb7AKzjy7U9vS9mzHcCDUCQWGh1rNHzFwfz5frpvHfo6t?=
 =?iso-8859-1?Q?VshutoqvUDVnD285FqyVyv6qhw0sp+luMHyvYdnXu/S/zuphXETY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: babfb87e-4c44-4aa1-5a7c-08ded12b5fe9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:28:55.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSLueNBqzgU4zn7SHetaYVjoZQ4MSFm5w/F8SLMl59Y2f5d15VxL1hdrUEhPrIMdNa6xUxHLVotD1KqLyRMGTgwzSAuEhZ5PoBBSKsWeqlBQOJVn6NmVi1/bPm4xmYdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8913
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11753-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@intel.com,m:noname.nuno@gmail.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,m:nonamenuno@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,analog.com,vger.kernel.org,kernel.org,metafoo.de,baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,aka.ms:url,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,intel.com:email,bootlin.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D9196B773B

On Tue, Jun 23, 2026 at 12:50:06PM +0300, Andy Shevchenko wrote:
> [You don't often get email from andriy.shevchenko@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:
> > > > > On Fri, Jun 19, 2026 at 03:02:53PM -0400, Frank Li wrote:
> > > > > > On Fri, Jun 19, 2026 at 11:22:54AM -0500, Frank Li wrote:
> > > > > > > On Thu, Jun 18, 2026 at 06:10:52PM +0100, Nuno Sá wrote:
> > > > > > > > On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> > > > > > > > > On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > > > > > > > > >
> > > > > > > > > > Advertise the source and destination bus widths through the new
> > > > > > > > > > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > > > > > > > > > BIT() mask. This moves the driver onto the representation that can
> > > > > > > > > > express widths of 32 bytes and above and allows the legacy u32 field to
> > > > > > > > > > be removed once all users are converted.
> > > > > > > > > >
> > > > > > > > > > While at it, give the channel width members their proper
> > > > > > > > > > enum dma_slave_buswidth type.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> > > > > > > > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > > > > > > > > index d47ff27e1408..19c258d511ca 100644
> > > > > > > > > > --- a/drivers/dma/dma-axi-dmac.c
> > > > > > > > > > +++ b/drivers/dma/dma-axi-dmac.c
> > > > > > > > > > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> > > > > > > > > >         struct list_head active_descs;
> > > > > > > > > >         enum dma_transfer_direction direction;
> > > > > > > > > >
> > > > > > > > > > -       unsigned int src_width;
> > > > > > > > > > -       unsigned int dest_width;
> > > > > > > > > > +       enum dma_slave_buswidth src_width;
> > > > > > > > > > +       enum dma_slave_buswidth dest_width;
> > > > > > > > > >         unsigned int src_type;
> > > > > > > > > >         unsigned int dest_type;
> > > > > > > > > >
> > > > > > > > > > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > > > > > > > > >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> > > > > > > > > >         dma_dev->device_synchronize = axi_dmac_synchronize;
> > > > > > > > > >         dma_dev->dev = &pdev->dev;
> > > > > > > > > > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > > > > > > > > > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > > > > > > > > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               return ret;
> > > > > > > > > > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > > > > > > > > > +       if (ret)
> > > > > > > > > > +               return ret;
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > This patch is okay.  I think most system only set one width once, do we
> > > > > > > > > really need pass down arrary.
> > > > > > > >
> > > > > > > > I think so. See:
> > > > > > > >
> > > > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
> > > > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
> > > > > > > > https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475
> > > > > > > >
> > > > > > > > And likely there are more. To fully support all widths I'm not seeing
> > > > > > > > any other obvious way.
> > > > > > >
> > > > > > > I need more time to understand why need src_addr_width, which looks like
> > > > > > > address alignmenet requirment.
> > > > > > >
> > > > > > > If it is address alginment requirement, only need lowest one, like suport
> > > > > > > byte, must be support other alignments.
> > > > > > >
> > > > > > > if it is total address space, which should be controller by dma-ranges.
> > > > > >
> > > > > > I grep kernel code, only sound/core/pcm_dmaegine.c check src/dst_addr_width.
> > > > > > (I think src/dsk_bus_width is more reasonable). because the name is the
> > > > > > same as dma_slave_cfg, it is easy to cause confuse.
> > > > >
> > > > > No complains for the new naming. If everyone agrees on that, I'm fine.
> > > > >
> > > > > >
> > > > > > So far, still have not seen user case, which more than 8byte for cap.
> > > > >
> > > > > On the consumer side the IIO dmaengine will use more than that (we have
> > > > > designs for that - that's how I found the issue). But yeah, it just uses the
> > > > > min value (it is just that dma-axi-dmac only sets one).
> > > > >
> > > > > >
> > > > > > Add it should only set min value should be enougth, if update only user
> > > > > > sound/core/pcm_dmaegine.c
> > > > > >
> > > > >
> > > > > Not sure how that works on the pcm_dmaegine.c. It sets more 'hw->formats' than the minimum.
> > > > > And IIRC, this ends up being configurable from userspace so we might
> > > > > really want all the available options.
> > > > >
> > > > > Hence, given that we do need more than 32bytes and some users (seems
> > > > > like 1 only) do look for more than the minimum width,
> > > >
> > > > If FIFO space require 32bytes data bus width,  4Bytes DMA engine should be
> > > > match requirmment, cap just help filter dma channel.
> > >
> > > I'm not sure I'm getting your point but on dma caps, the src/dst addr
> > > widths is a mask. So for 32bytes widths, we need to set bit 32 (which
> > > currently is an open path for undefined behavior)
> >
> > Bitmask does make sense, I don't think DMAEngine only support 32byte bus
> > width for slave FIFO.
> >
> > If support 4Byte, it native supportted any N*4Byte.
> >
> > So needn't bit mask to indicate all support bytes.
>
> > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > >
> > > > If memory have requirement for 32bytes, typical cache line length for
> > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > >
> > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > >
> > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > there... The code seems to use the dma bus width to match against PCM
> > > formats supported and filter only the ones we can support (per dma cap).
> >
> > if cap is one byte, it should support 8, 16, 24, 32, 64
> > if cap is two byte, it should support 16, 32, 64
> > if cap is 4 byte,  it only support 32 and 64.
> >
> > Needn't mask each bit.
>
> I think you missed the point completely. It's other way around. If the HW
> supports say 32-byte bus width, one _might_ assume it supports lower sizes.

what's 32-byte bus width affect software? It should only impact that if
memory address is 32byte align, preformnace will be better?

>
> It's similar to what we have with MMIO. Some HW, for example, may only operate
> with 32-bit accesses, while only transferring a single byte (8 bits).

That's means, dma address can't start from odd address.  The length limited
should be controller by dma_slave_caps::min_burst

In dma_slave_config::src_addr_width, most like indicate how many data
transfer by one dma burst.

Frank


>
> > > If we only set the min, that means the PCM code all of the sudden only
> > > supports one format and I'm not sure that should be always the case or
> > > that we won't break any user.
> > >
> > > I mean the dmaengine src/dst_addr_widths must be a mask for a reason,
> > > no?
>
> > > > > I would say the
> > > > > array is fine. IMHO, it's also safer (from a "support all" point of view  and really not
> > > > > complicated at all so I would just not risk it.
> > > >
> > > > > (we can also have one liner helpers for the case where only width is
> > > > > set).
>
> > > > > > > > > >         dma_dev->directions = BIT(dmac->chan.direction);
> > > > > > > > > >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > > > > > > > > >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


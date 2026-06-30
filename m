Return-Path: <dmaengine+bounces-11895-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o+5hFNkfRGpfowoAu9opvQ
	(envelope-from <dmaengine+bounces-11895-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 21:58:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9F6E7AE5
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 21:58:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=JV5sKsYo;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11895-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11895-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 256033006177
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2026 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7A472780;
	Tue, 30 Jun 2026 19:58:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560A472764;
	Tue, 30 Jun 2026 19:58:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849493; cv=fail; b=Mg2fy+dLraWw91ohSp12kr0hgiu0P+mP4kTeVc+OxglXQMXUXI7SN0CIWWju7Iogi2aKxsa7QsJUuimFIr2qmLPpgocjlD4PWdoAkETSzHytlJeUkOzpgVF0lgcPRlp4MFIXSnV++IavaZ3H3soroMfCCMFPFj6BeS9nwYN054k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849493; c=relaxed/simple;
	bh=Q3SUenRxfnD8MevGeqxDOR4CtP56Mq4/qpduHOTlKgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=blDDuvjLJ9mhFbRchnaJbmgPu7zMdO64q3l7Slnb36ZTZVA/WYi2DLPwdG13yd5hxG8lwhIQCJGkMPp3YOHutnQBl6L0tmw85d8Cw+m8P9Bk3vkdXXttYeD0PFcvHUO6WGfhfzMbRb5FQDryRWDz6PRF9w3+8W/I6EryVhoE6YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JV5sKsYo; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aczrmcNOIFf4mB3/6Yst7DU2pFEOvk/eyzgIVBEYAsLzR9OATCetAnNwJg+CSKw95Fq0K/2eYGq43WCFeFvDzuHXeDmpOSNJFFIL0OYMNq4VjcHFeKNxlycUvdheKhbn4rn5qs+ad10CYVuZ9jQ3iE7PEtFVhMAsjobAAuwEsBmwbsKQqTCVwT8Xjz9G+N66z5s5Xy4XwMelbEYzcUXaZzjyfIf0Y4YKgMp24ZBjxWZFe08nr/LTX9h7o6FK74hyEFMHvJPMYlhbK4lfKpfIlWDKxkXeE2ALCQz4YcLFqXPkR/wSrS+jbwB+EZUVZ+kCkRvioNgxg8xjfMOuJoyOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUt/W0SxL0it4VA4r19OSksfg61UnVn+mDYMLPpzkJM=;
 b=BepAO994QBcBjoIvCHPYOAr2h/yTAXjsbaYMlcJchGl/uk0hfb5/mDoGZA7JZJWh3ekptOsEtzrfpH1IlcqoCnmnYVqppuuhSF9uUi9X8pqo/8/69Y9n25RfOAzCoZIcThT2gLxV7wzVlDaClUrbsBeK8Wi1AFloeoi+bVaWGVIMz3NuDXMpmRt9u1ojzcJjGcuDbl8pUGGWurVE9JZBtGxaV456770aT3boB2t97whHNlfpGfIlrIlfn9eIpVpYgdKNizlukT6cEPD1YREC2ALRTiswStnXYRh/RGaqAem8dU8D7GtXRSzzMxfzVuF22olulFBn9dIgsrgQxogy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUt/W0SxL0it4VA4r19OSksfg61UnVn+mDYMLPpzkJM=;
 b=JV5sKsYoD/U4ovuMpNV5pLUlgOr8Zo1oGI4YK0n25+wfTkc9Ni8s8hUV5waLj57/erWLNqzhERxg0dD7esJRRCWUigjnnqbtHw7QFB6MbLeE8mQ0xoU4tkxHR+UGnpHaiFW2lxHZGoA9CtEDY9dCaAu4KYNM65WIAPpTmwhpXiUtK5mNeWinBSQQ0WWv9AqpaiP6VqbcxL0b0tqGb20SQx7wRS5SzQeT/SjJeJdiFff/gOb0CW3KoEsVGCRXG1t7n32dqgiXk6gkTnohd/jsrY9B7n+nV1TiLxB9Kd2keyvSecsMvKyl7QsZVLD03u+NWVy7Z8JyBnjo+DHcr43OAg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB9177.eurprd04.prod.outlook.com (2603:10a6:10:2f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 19:58:08 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 30 Jun 2026
 19:58:07 +0000
Date: Tue, 30 Jun 2026 15:58:01 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: Devendra K Verma <devendra.verma@amd.com>, bhelgaas@google.com,
	mani@kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <akQfydYXj0xwwVQK@lizhi-Precision-Tower-5810>
References: <20260626132151.1875965-1-devendra.verma@amd.com>
 <aj6kWCMbzyYC8Nh8@SMW015318>
 <791ac596-69ae-4eea-9741-0dc889111909@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791ac596-69ae-4eea-9741-0dc889111909@amd.com>
X-ClientProxiedBy: SA1P222CA0142.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 4419ae41-8cc9-4051-63d6-08ded6e1e784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	pmY1aE9kGaE9u5RQNxU4oMYSn8HVyiIQ+hsicUSuqtBVe2DD6q5yf03ItRvCsGFUiTQyM9jKO1ltA07Zvr42d0QwSEv0kzDKgThuozAzb5o4HEmaGQcqWqy3ha6F8iy1zjkkpt8ZFRsllPdDRt85y9nFx99sFj1xA0euL5SHjl3WziSUIPp9D4TcP4HfaVkGFAlAy5rRYO1+lzqeiPuc73F8yvDSqW/o4o98zvYRXh8t0obuzGbqBDQpLdtkQRieaALo9Ebz26y4lkeAIDzRzCX/YVZ15gO3OCAO6F8+W7AEBZs2Ngp+RevNtGjWK4ikONS+CtvAwL82PZdOiGT/KPQih6CFn++BmWUtdvOvS2W4cqAQPIZkV/zP+0yLxmmRDivGeJDfun+wS2iAssnsP8AH8mGWxp6u3cbC2IHFOlZ33jyB6R6fP4P65m6vSzbfED2sZpDX7KJOeaJHegl2lewyDsSzBSldBz+C4JFmxz9JWEKvn//yC0BL7MXTyczXIowjeZEJbpZ0UVXIvA0Z0r5XSucHqc8r+YELhL0cWtux+JFCXtkGkZwo7qqavJchSobGf2/pTFjqXsCsEql8MAtY/5rGt3OjBoDo0Vz88hQbeNiK7b3AzyCNyz55NHrtELy5d+WRIypyoRDUAnDlqd23FXZcIoXX3J+DMA6NZeU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+eOAPsHMxyLLdVlINjB7ETCWLZQzHSFIkQrMKcJQ7WaMTEFCXY06ncVmuo9R?=
 =?us-ascii?Q?YhsgSHhIXoy+ZOOtRosXWQsoSJCb37zJv0t4dhT88UuPwE7eVj577mw8VWv7?=
 =?us-ascii?Q?qCyoOolYeSLLqqd02T6RULtSQ2hh85jiqdZXcbomFKOnbRrzwVXW1qoMhiYV?=
 =?us-ascii?Q?KchYuGZ9LIqKbeZTkQRPM/EShdF44QH6Vr8ox841F1yHKabsq3yXpQWxQcHD?=
 =?us-ascii?Q?ipBUUIAdlSVohLJEFkor9N81CMj9TSajH55ikYijpUXmtH/F882pZs+PkxaM?=
 =?us-ascii?Q?Zcy00d9YNAvstP3XnG6Iv9wOdTa8lAZuw4R8pCZgPQ2QZLUUZVkVhO26AU8M?=
 =?us-ascii?Q?00JBsb0DxeBmfy6D40Smn1WCdl/Hmi1YAtrpGW56bvLb6grR/nqUxdkAG/5L?=
 =?us-ascii?Q?jilgUihtBJTWYgZ2b0PZppQYv3piYvnnuha4TWh/i2vogH3UyFUNs0+g5M7G?=
 =?us-ascii?Q?oycIFk3/HMG4DeXp/XbGCvLuzmz2l0aI1crR0Yrv24E6Jye0S8BN7IFp5h2u?=
 =?us-ascii?Q?Ii3Cd6IP0+p4aRC3Ml5nyAYj4MMCRQ7gLBMoZxCdb2vVi+DUc+uaHRvmx6C1?=
 =?us-ascii?Q?tOSEj1pFmOVQOqH5Z2LFRLG+Nv15ndb49k7ffCle5VUDvhMXW/TAGZredIcP?=
 =?us-ascii?Q?IVPwMXWFtfC++E6a1VpnwBKGddNecAZ83KH2g6gKUpEp+msret+Kt0DYvUV5?=
 =?us-ascii?Q?JgRvYSZYRP+YBU9yWaOwseMuRVGlNtAeGbZqFTuAyAw8s2eYnMj79N0Ji7rf?=
 =?us-ascii?Q?EBjXY9YvaYyP4RVonGuU55MFYO9X/TpM5k0bGnAyEB4co6z7xnsdpatg0hm8?=
 =?us-ascii?Q?hHW0mCkwh9tM7GfO5AunVvzt/I2yGzTdArZ0w6gb/dgw3yDknwh+9TlfEbF2?=
 =?us-ascii?Q?laxdKdJEmLqEypsHK4RKy7/TCP2/x08amHAaNvgdxJr+TM6BPFyxZMgPpQOO?=
 =?us-ascii?Q?SZ++fFyiPcTmkcQh53RqIbeN/7MQfZZulpU7cyk4G6eXFLynGR6t5voBKY1g?=
 =?us-ascii?Q?TXDQXDNs0pl9Eyl4wIiXhxmuYgyWPA6Kfo9aPuAzPrOWe6k35uRXgu4Bt2FG?=
 =?us-ascii?Q?HGKhp4mgeHjeGJISYEIsJsSU/uuDJeDjWDoWVFv6REouXRuGFGqP2z9BFKNL?=
 =?us-ascii?Q?rXzyLeoLLNodl1MbkjoD9+85shVTkUaYFd3YGy9DToHlzGUdeLZy+qwc5WFD?=
 =?us-ascii?Q?tfAXMwglUOqjwYiNwF+PxnU9mVz3HMzOpJGGSSAwOOoWtMHzpKwq25ik7Kb6?=
 =?us-ascii?Q?dJVpuq4HpMb4c3Bp3BoWVX1v5x7drxE1l2jMkYiq9osJ12JceycV0N4zC+hV?=
 =?us-ascii?Q?abh7zf4GQZWqDhghJ6Nnm1iwtSwrKoImKpqhVT4pAZF/O98bcwtlgPWTXTHw?=
 =?us-ascii?Q?tHj8fOxtUkW8Jb+2rhInthJreV+usMNDrX+eGiy7gOPNv5ZMq5sUJWHIWQ0o?=
 =?us-ascii?Q?qfrVFGvDj7NiWdJ0YuA3WK38/jGvrbBqVwSuA9zWNM9JirZSpVVSHlB5M8Dp?=
 =?us-ascii?Q?2GjJC5k8I4XUP5h90zqZXt7l5kr97DzdB3fx6k3BEo1Ydr7etAUF9t45a5aP?=
 =?us-ascii?Q?n0QyK+ATVFJGlItRx2kWDQcFoX98R6LHKg1iToPyPvG3PbF7TJK/X5FLGe/z?=
 =?us-ascii?Q?w4iPwhJx7D5V8VJs4FwBrHbhD4apW7J7dTMSzVchAt6PkmgoIOykFmJGDB88?=
 =?us-ascii?Q?B44bonWU0QKrhjKfG8Kq1SybLYO1eUD0MQd96rAaR+eNX/rl8SakGeZFACXd?=
 =?us-ascii?Q?iiumNfsyLhjJYDrVrD8fD1R308xjahtIjEOkkCVqlYMv+9gmyFdT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4419ae41-8cc9-4051-63d6-08ded6e1e784
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:58:07.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eehJIZvj8FtYHpIKKnCz32Gp/vf0RY3RTzwhCYeZscU/QlM9SqJMLjpJ8E3EFDfM56x+IA2lCs7zWrZJH5xrQRHfgXhQcghdPai0H5SI2YdqUlQMLyBBXGoYHFeQkZR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9177
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11895-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devverma@amd.com,m:devendra.verma@amd.com,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5F9F6E7AE5

On Mon, Jun 29, 2026 at 11:27:39AM +0530, Verma, Devendra wrote:
>
> On 26-Jun-26 21:40, Frank Li wrote:
> > On Fri, Jun 26, 2026 at 06:51:51PM +0530, Devendra K Verma wrote:
> > > As per 'Designware Cores PCI Express Controller Databook',
> > > Section 7.1 - Overview, HDMA supports 64 Read and 64 Write
> > > channels. Current controller driver supports up to 8 read and
> > > write channels only. In order to utilize all the channels the
> > > controller driver need to have the channel related structs
> > > and variables as per the number of channels supported by IP.
> > > Following changes are made to enable 64 Read / 64 Write
> > > channel support:
> > >
> > >   o Defined HDMA specific macros to reflect the channel count.
> > >   o The count of ll_regions and dt_regions in dw_edma_chip and
> > >     dw_edma_pcie_data shall be in accordance to number of read
> > >     and write channels.
> > >   o In dw_edma_probe() configure the channels as per the channels
> > >     of the IP used.
> > >   o Changed mask types to u64 for higher channel counts.
> > >
> > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > ---
> > > Changes in v4:
> > >    o Changed 'mask' variable to a bitmap type as per the
> > >      review comment.
> > >
> > > Changes in v3:
> > >    o Reverted the FIX for AI reported GET_CH_32() issue, as
> > >      per the recommendation of reviewers, need to create
> > >      separate patch for it.
> > >
> > > Changes in v2:
> > >    o Fixed the pre-existing bug related to GET_CH_32
> > >      interchanging the channel direction and id.
> > >      This bug was not caused by any version of this patch.
> > >    o Fixed the issue when using for_each_set_bit() for mask
> > >      of u64 type.
> > >
> > > Changes in v1:
> > >    o On review recommendation of sashiko bot, in the function
> > >      dw_hdma_v0_core_off(), the loop iterates over registers
> > >      as per the number of channels enabled and not on total
> > >      number of channels supported.
> > >    o Changed mask types to u64 for higher channel counts.
> > > ---
> > >   drivers/dma/dw-edma/dw-edma-core.c    | 19 +++++++++++-----
> > >   drivers/dma/dw-edma/dw-edma-core.h    |  4 ++--
> > >   drivers/dma/dw-edma/dw-edma-pcie.c    |  8 +++----
> > >   drivers/dma/dw-edma/dw-hdma-v0-core.c | 32 ++++++++++++++++++---------
> > >   drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
> > >   include/linux/dma/edma.h              | 10 +++++----
> > >   6 files changed, 48 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index c2feb3adc79f..adf1b3939f96 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -925,9 +925,9 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > >   		irq = &dw->irq[pos];
> > >
> > >   		if (chan->dir == EDMA_DIR_WRITE)
> > > -			irq->wr_mask |= BIT(chan->id);
> > > +			irq->wr_mask |= BIT_ULL(chan->id);
> > >   		else
> > > -			irq->rd_mask |= BIT(chan->id);
> > > +			irq->rd_mask |= BIT_ULL(chan->id);
> > >
> > >   		irq->dw = dw;
> > >   		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
> > > @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >   	struct dw_edma *dw;
> > >   	u32 wr_alloc = 0;
> > >   	u32 rd_alloc = 0;
> > > +	u16 max_wr_cnt;
> > > +	u16 max_rd_cnt;
> > >   	int i, err;
> > >
> > >   	if (!chip)
> > > @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >
> > >   	dw->chip = chip;
> > >
> > > -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> > >   		dw_hdma_v0_core_register(dw);
> > > -	else
> > > +		max_wr_cnt = HDMA_MAX_WR_CH;
> > > +		max_rd_cnt = HDMA_MAX_RD_CH;
> > > +	} else {
> > >   		dw_edma_v0_core_register(dw);
> > > +		max_wr_cnt = EDMA_MAX_WR_CH;
> > > +		max_rd_cnt = EDMA_MAX_RD_CH;
> > > +	}
> > >
> > >   	raw_spin_lock_init(&dw->lock);
> > >
> > >   	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > >   			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> > > -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > > +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
> > >
> > >   	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > >   			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> > > -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > > +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
> > >
> > >   	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> > >   		return -EINVAL;
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > > index 902574b1ba86..d12fefbf3952 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > @@ -91,8 +91,8 @@ struct dw_edma_chan {
> > >
> > >   struct dw_edma_irq {
> > >   	struct msi_msg                  msi;
> > > -	u32				wr_mask;
> > > -	u32				rd_mask;
> > > +	u64				wr_mask;
> > > +	u64				rd_mask;
> >
> > Can you direct use DECLARE_BITMAP(rd_mask, 64) here?
> >
> > >   	struct dw_edma			*dw;
> > >   };
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index 0b30ce138503..79f653da8e0f 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > ...
> > >   	}
> > >   }
> > >
> > > @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > >   	unsigned long total, pos, val;
> > >   	irqreturn_t ret = IRQ_NONE;
> > >   	struct dw_edma_chan *chan;
> > > -	unsigned long off, mask;
> >
> > after change wr_mask to BITMAP
> >
> > 	mask -> *mask
> >
> > So needn't change this code if support more channel in future.
> >
> > Frank
> >
>
> It looks good to make this piece of code generic and support for more
> channel but I did not push that change as the final limitation comes
> from the HDMA IP which as per the documentation supports upto 64
> channels only. As there is no channel increase BITMAP was not
> implemented for *_mask variable.

DECLARE_BITMAP(rd_mask, 64) the size is the same as u64. needn't call
below two bitmap_from_u64().

irq->wr_mask |= BIT_ULL(chan->id),  use bitmap_set().

Everything will be simple and better extendable.

Frank

>
> -Devendra
>
> > > +	DECLARE_BITMAP(mask, 64);
> > > +	unsigned long off;
> > >
> > >   	if (dir == EDMA_DIR_WRITE) {
> > >   		total = dw->wr_ch_cnt;
> > >   		off = 0;
> > > -		mask = dw_irq->wr_mask;
> > > +		bitmap_from_u64(mask, dw_irq->wr_mask);
> > >   	} else {
> > >   		total = dw->rd_ch_cnt;
> > >   		off = dw->wr_ch_cnt;
> > > -		mask = dw_irq->rd_mask;
> > > +		bitmap_from_u64(mask, dw_irq->rd_mask);
> > >   	}
> > >
> > > -	for_each_set_bit(pos, &mask, total) {
> > > +	for_each_set_bit(pos, mask, total) {
> > >   		chan = &dw->chan[pos + off];
> > >
> > >   		val = dw_hdma_v0_core_status_int(chan);
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > index 7759ba9b4850..48e40efceb2e 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > @@ -11,7 +11,7 @@
> > >
> > >   #include <linux/dmaengine.h>
> > >
> > > -#define HDMA_V0_MAX_NR_CH			8
> > > +#define HDMA_V0_MAX_NR_CH			64
> > >   #define HDMA_V0_CH_EN				BIT(0)
> > >   #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
> > >   #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 1fafd5b0e315..da7a5cc93ad4 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -14,6 +14,8 @@
> > >
> > >   #define EDMA_MAX_WR_CH                                  8
> > >   #define EDMA_MAX_RD_CH                                  8
> > > +#define HDMA_MAX_WR_CH                                  64
> > > +#define HDMA_MAX_RD_CH                                  64
> > >
> > >   struct dw_edma;
> > >
> > > @@ -89,12 +91,12 @@ struct dw_edma_chip {
> > >   	u16			ll_wr_cnt;
> > >   	u16			ll_rd_cnt;
> > >   	/* link list address */
> > > -	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> > > -	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> > > +	struct dw_edma_region	ll_region_wr[HDMA_MAX_WR_CH];
> > > +	struct dw_edma_region	ll_region_rd[HDMA_MAX_RD_CH];
> > >
> > >   	/* data region */
> > > -	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> > > -	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> > > +	struct dw_edma_region	dt_region_wr[HDMA_MAX_WR_CH];
> > > +	struct dw_edma_region	dt_region_rd[HDMA_MAX_RD_CH];
> > >
> > >   	/* interrupt emulation */
> > >   	int			db_irq;
> > > --
> > > 2.43.0
> > >
>


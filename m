Return-Path: <dmaengine+bounces-12361-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IicLJRV1VGr0mAMAu9opvQ
	(envelope-from <dmaengine+bounces-12361-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:18:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C10A7473A5
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 07:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=CI+k9TQn;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12361-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12361-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95C203003BC7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519033546C7;
	Mon, 13 Jul 2026 05:18:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589E35FF5B;
	Mon, 13 Jul 2026 05:18:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919888; cv=fail; b=anCdzOAnN2X5BF/H2Ch10OTF4q0BbMgT3vSixIpEOw0IClAZG3COs1c8UYegY/eNtQALnkPs/vDJ4Hl7AHAuLlFIGaVLNAAUM48ngbhs6cb11x7UTDcPIsusK8b94Omijbq9tliOLzTCzEYL4YDWaVPtti2Wpd1k75A+dxKl6Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919888; c=relaxed/simple;
	bh=po0CArNG2YlpIXXMO7OfAU4dXS2XYklZKmHfGH7rznI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kqD2d6/7Vg3M4EW+So8BylLsaUL/Zt6v/vyDoQs0defuqMMe3XtfYFN3RY+l8s4YwbSDHkAvOdWQf55PwWr7UIsRoV5BDfblPbEYWE+5TypyroZ+fWAIDoW2n1MCpHeg/pFSs+kVvTnJuUzmdeV19mCVxRmNAupMQZW+617y9wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CI+k9TQn; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tzmda1hpGio4mc5zZZ8YXv/hMpq8BYdNjqIVkSQliWkkTAoeEWHf8MYQFxW6+cpQNIVn/nh5GMfebKggEe4NdkraUMP96z5n1B71YBOIgMO9oSkygWag8imi0zgt6gBG2m8PDPklEbk/yxxGAVZCacsI3NghMuNOIOym2hbKQixHTuWfM1hqqq98M1Ac4dunpB9StN02pJYItAvauXd22BT4FCv65M++6qRFqhxoAI0e3m46NiPENafv1SLl2/TAKM/fCQZAW1qAbmXN1xMV7zZ85/rJFbOiAJ2PbPO2sfpTh2w2EOze1GxjfWrV2SkcU+ZH81rV9/dOxMQzTXSSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPdLWcZ6H5Vcl0541b2Jt7VfY8dRmKvBrdDL3+HI7Jo=;
 b=cyS6jFch9bd6ySAOqEGY6ftiOR+sWcUx6FXuzXUum5xwtoEHChlAMkdiT3H+S5qnGhbBAFLqKr1AU5EtjX+CzskqtLO9iMQH7trmdl9nZrU6JxA8Ul3xlo6XHvJge7XjSagrKC7W1cuES8qbJAZGNRpB0Pu87GoHC/HPMY5X0kU2j+UCtQtGsoktj7yanWamEqNeqjmW7+qtt90Qq6IP5VDN/zM6e7GbRDQciheGc1rwKX3WXPLLnudtzb4PULqyjM/KP/34e4/ws9EgGsAxAVwdZ38WKYF/UQebyWggz4sjW5SHUn+g5zi8KCpQjB2s6rY375zZ1wO43Jw72/r1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPdLWcZ6H5Vcl0541b2Jt7VfY8dRmKvBrdDL3+HI7Jo=;
 b=CI+k9TQnv+NbOASMKX30wCrA+mHpx52a8pyGYG2SRUC3EjP/rEQqdny1wK/clT0e0hJ/OtKtclaRb2770O9Y023n6F678Ii0UVzxIWSipNxNNnkurboaANz2pkdrghVN3DvhAo4qDUCGtx2TuDsteZfggLAx3dq7Vgz0XfuNWhQ=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2828.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 05:17:59 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 05:17:59 +0000
Date: Mon, 13 Jul 2026 14:17:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, 
	Serge Semin <fancer.lancer@gmail.com>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	Devendra K Verma <devendra.verma@amd.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dmaengine: dw-edma: Fix HDMA channel status register
 access
Message-ID: <mmhhn5xgcw2oxphw5jlmon4lshyc4whtyui4hh4y5zw5qynodg@6jex4wwqrrye>
References: <20260710080903.2392888-1-den@valinux.co.jp>
 <20260710080903.2392888-2-den@valinux.co.jp>
 <alFjcLq5q_47uomJ@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alFjcLq5q_47uomJ@SMW015318>
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2828:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edf9308-de41-4678-d566-08dee09e1ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ma8W9sJn9A4Hx3hoKAHCC/So9wxuzkNCGAqVirC2kLn0hGnkLWRYQPO4+RZh4rBY2FaABScluRhZBqnG3k3GoO8W7Sniq3FWsK5rGgxeRbkMSfW/OUeQWkaotFr8nA1yJABbNMYEVQV859rYtRPQiqN+nKeon2Ch8wyP1yM8i+as50iX3mYKRonPk3bBghlgrw8rF8nu44/wxVxC1XJhtpsBPfattVy9QzZQCFSOPIWz2S2TanoiDfevexedoY6kyq323A8qJAh7YcWaemToP/MdpR580NpO5llXU8iRbS6lmzmh/vu7Dple2D4XQgFpTrQRCHUjQIdRPNJf7IJtOUD6mk50IZFSEaIUPUp07CGxqZp9QVWrmI1r9rP27JZv99iyoU4sIw9hx0jtPu4cXeSKRKBSzZNK9+FKhrTcGT8GUBQX3z/VnHlDZR320/Oseg7T+VlFo/YETsmYs7AGl48kEkmrVKHO0IJEOsRJQQ7WR5ldq9q75wp++SWwYzn6Q0tI8/aqGza/wdwUwTYV5catK0GTmFJRTprS6mMB3VkIeVsu4T/yxDasO+ezFSZnqCCkNHY/9QkUxPL7fcFZ0Wni9HW+q8AFTOsSsgoFpIKlM+Oqzd5BvV6TajsVKTT8EpyRINk3TNa3wi3qXHBzxrh0R1o2+Hpls24zsnAObXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?37Iu2hthRW7uUs5mbOmr3mecp/fsh9nCYms4Frk4jLm7QDFXCLVada5GyFJg?=
 =?us-ascii?Q?SHP+RXj7C7IAvkApIUjWOxtetjx1+IMP7pDoOQqWu8u3hXEwoCFTBH52LHoP?=
 =?us-ascii?Q?byEcCkzz7+ddjEWffJtv0Wa0X7GEdc4OmcT9VkLI0xCemrO1bzPNYjUjzwqN?=
 =?us-ascii?Q?3j+7f/N9AN57SupmO+a7Z1uXrb+OcYx6QJK/IGjnyaIGiQIC7C66chIMUJms?=
 =?us-ascii?Q?SOAzN9HQmrMeZVgqielD1ioXmObUiNWHa+ha9zq1QdDi+wdy/MWThpkuaPyC?=
 =?us-ascii?Q?bdGcrpzrX7GkWvTcQRe2LzTSr0JIyX2rp/9VJjxg1lmXPogZs1i5PeXmFwCk?=
 =?us-ascii?Q?G8tup7mLQaR/kyV1diItV8lFYkYVZFVnILsLfX/ScqXMZYHglZJd6lIep/kq?=
 =?us-ascii?Q?+oNiP0ewF48R7Bx2q96JCx85QAQRG1iA5DZGCHQ5Y545K3wsjRapOpMdo8Tb?=
 =?us-ascii?Q?LLklpplG7G4YOs+fDmbYQ+7GDaRDCWzmenZQ99IcblEPmdYtQGObNTSYH3GL?=
 =?us-ascii?Q?bH/BuW7HfyQxeA6hiZk0FdHUhUWRDIAf8nbKa7JyhV4L9qAKj51P053+Pudg?=
 =?us-ascii?Q?iRpQ8HsgN+zMTKs7Xe8PzMrxyLzOigqdc3L0plRjBSoVoGtCfSd7OpIX6HeX?=
 =?us-ascii?Q?7ZOSTeNDFv+A/2nfNdBeeify3iFqE/cS/Dn4t7rnYQHZmvFNBopZI9kh0TQe?=
 =?us-ascii?Q?qfdIzhXxNAq8ugvbNdMgZbOv2FSJ3PvnHVOpA8ssOC/WRJ0UqyQBh3qZAmys?=
 =?us-ascii?Q?0cAUII8iO1i/UlrtYg/AX7+segNeBvVOsw+rVuCDdykbz2JvVU48iRPBGYGQ?=
 =?us-ascii?Q?T8fKS3PirOz7h0vy1gUaoqFMCJGpGciITwFyUc+3jA77r0x2Ov6B8+gByp7k?=
 =?us-ascii?Q?d+IKmoK0plNb0B+jHNV29dM1nwlOtIOAVqV5DTN4QxpnR4gUNpjXhhz16Mj9?=
 =?us-ascii?Q?vG7e+FsAZ7fu/yaxwBmW0e0o49z3kkvBr/7TW9NUopn0HUYGIYSDi1vyzoED?=
 =?us-ascii?Q?d5XKEbI8YD7PjAnenAXSQxQTl9rsbsuL3JMn50X/hwl8WDEOepm9wvp8sJjl?=
 =?us-ascii?Q?FuefdF/1YbYq0TqHZj8VOX0TM8O1KJ6jo+iu7T4hPp2hQnENElvT1R06hQ2Z?=
 =?us-ascii?Q?wyKiwgWru+EyIFprjlu63z/HygMSLMGRnL5Ya8PJyWnXlq05JUeiBADi9q7t?=
 =?us-ascii?Q?QXeVZHjtMRQudSQsdMl6y011+wzZF6uZfKI2QIVYXtVQB4VZqOno7tOScTlG?=
 =?us-ascii?Q?0blR3902GqFa1RhtCmOPpocihvnF7hzTTEdcshlYkWpx/Dk821WDUORvV75t?=
 =?us-ascii?Q?Qcsz9N/xwscGSPmpBbRGUVqsAFf2Nn8DjXQTVHSN5GUsBCSwEILqpI59Fm0y?=
 =?us-ascii?Q?QpyG/TlheS58Yp2kXTJqm1Tpokg64jS0bx5L2MIvBTXHQK8IJwGM93Mr2UnQ?=
 =?us-ascii?Q?YeeddmjNcL6WkC4wZ5JDBJ/WcHy3qiLcPe3fG83MX96DFeSs51c2PagYSzJt?=
 =?us-ascii?Q?B7r2NTP4I+9V36MRvDSD8movTB832e67IWizoeDpIry1Ri13PSkCn1ukRWZY?=
 =?us-ascii?Q?92ZP/75UWYx/CQV1UDTj6U23W20AMRM3ap6J/BOgacKRi4m+WnzvqNWRR+Bg?=
 =?us-ascii?Q?FqDMWA+TA4mVZpHUqwu+G56u+n8fI5yGC5MInLItjfsb21WjXsAt3q1F4pRd?=
 =?us-ascii?Q?dAqfLBF1gal+3cSHW5TBvbcJOfB1oZ+G6cnthpCPZyy4ZBIYDDCLiJp4d3UM?=
 =?us-ascii?Q?DFEd4tN1a/Nc9hhqicHKERSWgJV7Yi74W6g/y7oZm9jFRgkdxLzv?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edf9308-de41-4678-d566-08dee09e1ae4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 05:17:59.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GENlhnevlBQF43DeS52tj0+GQ3GaKSeGsU2HNuyw+gcQsPl0q6D88rixkESBLV4U4LtiApt9LGS7x8RpRr5epw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2828
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12361-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com,amd.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:dkim,6jex4wwqrrye:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C10A7473A5

On Fri, Jul 10, 2026 at 04:26:08PM -0500, Frank Li wrote:
> On Fri, Jul 10, 2026 at 05:08:57PM +0900, Koichiro Den wrote:
> > GET_CH_32() takes the direction before the channel ID, but
> > dw_hdma_v0_core_ch_status() passed them in the opposite order. This can
> > make the status callback read another HDMA channel status register.
> >
> > Use the same argument order as the other HDMA register accesses.
> >
> > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> Do you miss version number at subject?

Hi Frank,

Thanks for pointing it out. Technically there is no v1 for this split-out
series, but you're right, I left each patch with an added "Changes in v2" note
so it must be confusing. Some of them came from the "dynamic append" v1, and
some are new. You seem to have already left some comments, thanks for reviewing.
Since some of what Sashiko pointed out seems real and I should re-spin anyway, I
think I'll just bump it to v3.

P.S.
Let me just tell you here that the "dynamic append" attempt seems to have opened
a can of worms. What you observed previously as a missed doorbell (written in
your RFT series) seems to me just the tip of the iceberg. (Of course you
might've already sensed that, I'm just going by what the RFT described.) At
least for legacy eDMA, ringing a doorbell while the channel has not been
completely stopped internally led to various issues, even if it looks as if
already stopped from software point of view. When I put heavy load across
multiple channels [1], the issue starts to be observable in a reasonable time.
The details are really complicated and my solution made the "dynamic append" v2
series expand to 26 commits in the end, which is too large for one series.

That's why I split 7 patches out of it and sent them as "dmaengine: dw-edma:
Fixes and interrupt-path groundwork" series.

My plan was to submit in order:

  1. [PATCH 0/7] dmaengine: dw-edma: Fixes and interrupt-path groundwork
     # This series. Should've added "v2" in its subject.

  2. [PATCH v2 0/19] dmaengine: dw-edma: Support dynamic LL appends
     # Will send shortly.

[1]: as you know, the goal of my relevant works is speeding up the ntb_netdev
     EP<->RC traffic, and now it reaches 18.7Gbps/15.7Gbps in each direction on
     PCIe Gen4 x2 R-Car S4, DWC PCIe v5.20a eDMA. eDMA use saves us from CPU (or
     DMA) MEMCPY in NTB transport layer as well. That is a significant speed-up
     since it was originally 500Mbps ~ 1.2Gbps. "dynamic append" is a
     fundamentally important piece to unleash the eDMA performance.

Best regards,
Koichiro

> 
> Frank
> 
> > Changes in v2:
> >   - Split out into this preparation series (was patch 02/17 of the
> >     dynamic LL appends v1); no changes to the patch itself.
> >   - Collect Frank's Reviewed-by.
> >
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 632abb8b481c..2beec876b184 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -79,7 +79,7 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> >  	u32 tmp;
> >
> >  	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> > -			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> > +			GET_CH_32(dw, chan->dir, chan->id, ch_stat));
> >
> >  	if (tmp == 1)
> >  		return DMA_IN_PROGRESS;
> > --
> > 2.51.0
> >


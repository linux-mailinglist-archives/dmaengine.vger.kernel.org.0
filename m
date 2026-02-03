Return-Path: <dmaengine+bounces-8702-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNvDD/VrgmlkUAMAu9opvQ
	(envelope-from <dmaengine+bounces-8702-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 22:43:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4805DEEA3
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 22:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41F483011A69
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 21:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36589364EA9;
	Tue,  3 Feb 2026 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQ76DmTZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87E26AC3;
	Tue,  3 Feb 2026 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154992; cv=fail; b=sGgOoDrfwqSVPOvGa8gk1v+6evW7QvIJUCWBfQA47De9ZCTzCCyvQmSYawqbcBzIGuR0FAp8aZRqkseTlanQco8vA5YE17/lu5zf7TLQWDcY8PxzmEx4ZfY3suwes55kyUqyyhSkZEoFWvb2xZlO22H54WBUYHQuaaoKHD7E7Yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154992; c=relaxed/simple;
	bh=Rlwv3PpvSoAOHy2Iz+uDbewD0wWNFEGnyFd3XGoRsYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=swD+0/em1MZ/mepW0U2VKh1Bljx6z7a2YJlKuH69q7tlyEoygdbTeOAjvtvtjWsBqt8hqJ686CyILzPrG0eLzFEcK1sPZEECVjp1snU18rTGomaS0WZDUwMkOyw+ghXh6zQGee7rDYivoobXFrN1YEQjsnrIaWi3n7nFQt3UoH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQ76DmTZ; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzLCCHG6AhLM784Nkdsk2Gbr1+lc6FdGwAyoxiz0WGdNStViwYjEewMfl4gCEhxBxk3x4BEOMB5zXt6yVi/qhPJniRfS5rhmzGjV75Cu/Ur7tSDfmnirvlxxwdu4LffbAYoMxYRFFnSCFbM1bV8iWhBVX/0aNTiemg++9Hcjqk14sTtccEk/8yY6/Ld6v7/f8B58sxrER3hZ5CXoj2QsSKWPZFT1UKE+PWmO0AU/WTRhVkNfuaSSSC3C+QAdsME7llFsTT1Dc0LVTudskxEYKFw2I+zelMqQPSm5j4LE3EwegzxJN6OMoPkOv3mqGVJg7hj7YKbbxXB13xVfDU5o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSKyGkizW8zdyCHMWoWHQYWHEP8X3NanJeNhKAtyTLs=;
 b=VncIxRNVxKX40yfsbgo3fS3LMtbFwUUaLrYndRfQBOco96+mhocNNv7bDNBQcjWCg6Ch06GvE4diNCS3s+gPPGTTYwGFoJBkkBPvv1fM8J9jxE3x9ihMnM25O+O0RfGB/uTOjNnnqjWfq+QwFInxfGrXItot0vl8wdurPG2kYGMLy6mbBHeEbKE1qnYAm+yvMWc/D4xr6QtTqk5MPGNXMtkwfz8gBXVCz3RB44BEOK57Ovcco+V9J8K/Oc2xaFlCJ6P691aIoj9tyndCmdVNOKeTB5pMp8Mgcb+D+JFeO0TXAgIDfR8AiFL15JnGOeLc9cR2W5eLRqOHyFJ33aV6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSKyGkizW8zdyCHMWoWHQYWHEP8X3NanJeNhKAtyTLs=;
 b=eQ76DmTZ8IO3kmtZtg2WPWykM3RBvG7ab6GDUUDp/wpqXH94EodVT38NCU97k2jGkfrqmfuronke45xiENXcta00lAiaAxF/Nqsu3cR7Ow5JWfePDJqPrU9uRGG15YF5/Zx5uMK3UJlxquOFbpR9vJFHKH9qzA59ZGL9YHFmU6qHu7SAkOygYSbZWKI1XSLz/miOICF0lT9DtT1YdzCAyaHC4iIOONFZFlzhBSxZl9z4PNSHKQ/ePxvtCZlv+PtrwSvShktcbx83wyxGmYNyXmWJnm7HeHgFt1SJdJzhl6QgA4275eCz6UzCQxgMZrAzB/8o4GmiBMXxYNjBjk5rRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by MRWPR04MB11285.eurprd04.prod.outlook.com (2603:10a6:501:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 21:43:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 21:43:07 +0000
Date: Tue, 3 Feb 2026 16:42:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shi-Shenghui <ssh.mediatek@gmail.com>
Cc: vkoul@kernel.org, manivannan.sadhasivam@linaro.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	brody.shi@m2semi.com, kevin.song@m2semi.com,
	qixiang.zhong@m2semi.com, tom.hu@m2semi.com,
	richard.yang@m2semi.com
Subject: Re: [PATCH v5] dmaengine: dw-edma: fix MSI data programming for
 multi-IRQ case
Message-ID: <aYJr4x2uADwhIKYQ@lizhi-Precision-Tower-5810>
References: <20260202055344.1395-1-brody.shi@m2semi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202055344.1395-1-brody.shi@m2semi.com>
X-ClientProxiedBy: PH1PEPF00013314.namprd07.prod.outlook.com
 (2603:10b6:518:1::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|MRWPR04MB11285:EE_
X-MS-Office365-Filtering-Correlation-Id: 30718133-0b32-4828-0bf3-08de636d37d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?StaewNhHe08eVT3hAzkiNA/tPyjbBhq0prwgI9jpzHwBazmXKRNSajAAoPV9?=
 =?us-ascii?Q?bb9hK6J0x+I8McRrH5lwbFq5dSFuQHjMkIvFS6mpk90D36VljJJLZSRfGA9M?=
 =?us-ascii?Q?GdSVLs31ehqKbZTxh9DMt51I3F52yRTZ94BzOtHq5vBv6w8/YZaCQ4wLxiJK?=
 =?us-ascii?Q?sQ270ZMfxY433cnZQibRpnNdCzJ2IIOOFGzfzpQS8Ed5XfXX5RQUIczybYXE?=
 =?us-ascii?Q?0d8wla/Fjjp0B1NFJ57rEgiE1JONNmtL9XjeuaPZnLCrhWZKVYsgL56ZdSEV?=
 =?us-ascii?Q?WwlM3GUZ5568fXeR55OACTgwCGBpKmaEOTpvX8rdMB/sVRCbNcziNMykcZTr?=
 =?us-ascii?Q?HeLSLiv86b63XPSf2mcndg/H9zqigVbJuBcPPNNvFp5z/eLmkNJUcjAdu8eB?=
 =?us-ascii?Q?YpiN/qFf4//0g0+Q23ZQ2eP4hrMG5oJze9UnlB8DHSLz8FBKckmi7CpnFlNQ?=
 =?us-ascii?Q?lQVDdOjlelTDMfuVz5+jWIQrq20ot1kFJQ/exzz8fntEXMvpVYkQlMaqsAcW?=
 =?us-ascii?Q?a6eKNH422Ln07NdatR/qSJm4Bke7iwuBxJUJXYua6mdGIkb0ucGZYkGesDw/?=
 =?us-ascii?Q?VaOCYyk1qgsicpw8wDbzV/J+AeHNfTytrAhK7nEHg56hCkQ7TyEAMhwPbYxo?=
 =?us-ascii?Q?93nMa+5qIBSNgWI29MiO66DrucvS0StUhpcmASvPkv6iZ3XFOi2mlwo0JOUJ?=
 =?us-ascii?Q?jQg2JGBcQU3zViIs3xu7vn6o4MH76gGCtfiglZhuEAtrnUZkUGM1UxYVn//s?=
 =?us-ascii?Q?zN3KkalCMyP31Kt+pcaIb8NPaR1FUXXIEYl7k1VOJZyw9hVHNUfkI6wqBBnK?=
 =?us-ascii?Q?GylT74IYn5fdf+wJsXC/c1phST5aOlqnkODTcduwLPUUzpirIEjmd/ncmG5L?=
 =?us-ascii?Q?nzM9rbrdn9Zj2yUu1WHt5UAr5bnF6PnUAcwEXEHzs7jzrb6JK1sVneJYwTgl?=
 =?us-ascii?Q?y1lVklcBDegIqrbOUGPht9/ddRidiaKNpssTBwBXQ5t2MZHpn+6+jjKeVy0g?=
 =?us-ascii?Q?e5fBEcyOkxfRMvotxHnkJAOtY1Q3PVgFOjqyxjOAp+YqwVzYPz5ksPQQClEP?=
 =?us-ascii?Q?psg9Fe3nEKV1X7ea7+GHI+OcStrhICSMWvbeU6Ry5xyg7wyJBBsp55YQBnSn?=
 =?us-ascii?Q?wxSbGllXyieROcLDJbV5UnrilIUZ1yeWFF+cj6499AuwaGdnl1QhuE0qEaTo?=
 =?us-ascii?Q?Zc+WcnmYBNLRSYwgcCEyp+P86SNwn1ZopbH3EOETib+1Yd0hiagacESek32Y?=
 =?us-ascii?Q?gP8iFFKahb3noh8ciUEm7fmMJIdQirrbRdP/tuKDhrsmRt0tR0x2PyhrCYs+?=
 =?us-ascii?Q?h07RgOc2Xjnat0Zc/3MpxGz7WYW/ZMwKG07eyytzLND8/MQTw9psXtgUONFW?=
 =?us-ascii?Q?x2UmbVbGaqiFpZrXMu5Rry94V+jVCzKQ1TDA6faooEG2KmVP1boolphEDLme?=
 =?us-ascii?Q?Vvt2FEXtWx129aSF45QSKIsB6Byu5S5p9smR94Hvf7d2huIVv7nuAR78oXLk?=
 =?us-ascii?Q?pP+/b+MSbzx/8yeZl0N9yVBIHasqdRuLIenvkC3S6PqIvziuvsrlnp8Rdnet?=
 =?us-ascii?Q?ounh41TVjmn2f8juCPvsPUKAglx/UlUSfwKHQgwOkT+xHukkIBr0j/NN1/BS?=
 =?us-ascii?Q?kyHDfJiFGXi97jSb3lYL3HI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vFTA5YLy2PIlAb/jOC4v6/hxpl9+H4cW3ACBO0iY8SyUDmPX6UEfub2+B4qu?=
 =?us-ascii?Q?7BS44PBdMTTwCP0p2AiNrU+dQkESSkRDAMrEEN7AsWT9pz2/odmnaRKEUNgq?=
 =?us-ascii?Q?AM7Yl0oJdCNdRqElCRCXV5rpwNB88RrqmqTPm4PXv40zLcJB029nZC/CTUYl?=
 =?us-ascii?Q?qFjuTGHPcDQzl9o+X0oXbZp3qoP/BJ8K8etp484QTQQMEIsC1CW6k5ZbttVd?=
 =?us-ascii?Q?zKkfJ2J+6kGoEuqyCU440QttCpu0MawXHzDBpZfMoBPMb+yXzxwt7YmQMCCi?=
 =?us-ascii?Q?Hfr+bN6S8btxcvf0aVJLpW9/QAwwML0BSPVdP6t/Wky7wQCaWTOoke3ngZDH?=
 =?us-ascii?Q?h5YQ7tdeGzEGUFgTKD7suuXJCdtR+YAZ7WIdZ/HNvjkRImJPeE/9WpTZ+Wv0?=
 =?us-ascii?Q?2ajtJmb9z4eRZQeTOxITUqyeSyXTjHul8Uky1n2Km+uHdMNbO5aUBlpYX0VX?=
 =?us-ascii?Q?/72EmlNBQPMzRKX/ox6UORI/uTBEjnxYZIqF0SIPVoZcYsRc9N8W4o172yr6?=
 =?us-ascii?Q?N1snck4Uw2YheGQgAJLIsATCin8Lr8yg4jRUkOBV9qz+hRJsnymD0CYdSSPC?=
 =?us-ascii?Q?sxt4PGFtP0s0XqhnPgcfPRHkMubyJ5r9fWWtwCyl/WQN1zoTWHu9wLpst0fO?=
 =?us-ascii?Q?SGb9eH1kenZOsK9nZ20PXaCFlZUDVrycyVWQk5eA0C33pGkZZssLxgrH33i9?=
 =?us-ascii?Q?OoQVHGfJ+0+08vZdyLx9OOjQJ1jQZ0nVU8G6eMXySTejfYoWrn0aRRdehtKZ?=
 =?us-ascii?Q?UOfLffhPQlcQQvalmBfiQBarLG/c8GY4k24Z2HPoojnp2KRQk0/tCDa6GqN+?=
 =?us-ascii?Q?3DPTODpc6eSRZ+U2xKaDI+f2NLFHIYzoLxfqZ5GrxCWWdQcKR+6XyNGMC55d?=
 =?us-ascii?Q?jmBCFi7A9jnocewuRWl1X3+DAaOpLhD0zScQBGHN3TXHY140jxdK/4o3w2vs?=
 =?us-ascii?Q?JdeRSKCe02ASggnAWRnSV9bmAW0WR02lvhvPK9v94TssJD4cLC6ft6XRIJxe?=
 =?us-ascii?Q?iYL8jbjILrktAYgBimubYe+2OB0Sy6TUx5+p3DpcwlwWMsj++v53rSoPMUj7?=
 =?us-ascii?Q?Q3GA4PUCGhTOe2XpZqWnM1A4R6DwVy8o6IfzGLxlJXc543J+EwfwlPFCrPDV?=
 =?us-ascii?Q?rJGOo8yRXaeiwMalc6dMhe0eddxgI4MvYWyOrojoWDwew1svTORG377Rdg1s?=
 =?us-ascii?Q?KIf0tNrnXdjTbysZq1vBQv41IlKUWWj5Gxbd5EurXAZ5KBShLRpMbqR8OeKx?=
 =?us-ascii?Q?2Jcy8tJWDHFlIe6hblC3M/5DfEFdYgA7UgzvsqTE2gUe/ynMMnBDfwJKxI3Z?=
 =?us-ascii?Q?5nWILm+hP+k2NfExLcM1akY8c8uJzl1UJ5ICKjwTiz41xWDph/CetF974Wjd?=
 =?us-ascii?Q?SUarrf3b2Yq5Pn6Xbc6P6tqtvg4bdBkMVQiltV44PAbhUp3l++w7cPHqUnil?=
 =?us-ascii?Q?cwlnE3s3eROOjdETrQm7dzGVt5MgVbvX4+e/CeMzRhwOx3iCPztbTNJfFMWB?=
 =?us-ascii?Q?vsSU37fDksD9i9VB1M4JwqzfQLj9gJPNzpbCq5pv0+t+/nbZzJbM1wEglLn5?=
 =?us-ascii?Q?EdGkl0b9BDsKGVJFz+dMUFwnogvBYw/mGturMpeZx9DHNl/Wc2+FoL2AZ4Rn?=
 =?us-ascii?Q?AP2d710nFXr3yblx+MuM4D3li0Sf0WROL6dPGI6bfhnn7urspt0H7m2U4Ehu?=
 =?us-ascii?Q?neif2q/zxNZhjIM0HXWJ5fNvdptOLOayo7EcWptGR064KJo8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30718133-0b32-4828-0bf3-08de636d37d1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 21:43:07.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/OtDUsk1/g8ow9BoO+NrcykJESd0502QllDs3QPsSByxINWZaDUGGNLmQLsepivrbMOGIuZ8ICFmHZ/HHWVTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11285
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8702-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,m2semi.com:email]
X-Rspamd-Queue-Id: A4805DEEA3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 01:53:44PM +0800, Shi-Shenghui wrote:
> From: Shenghui Shi <brody.shi@m2semi.com>
>
> When using MSI (not MSI-X) with multiple IRQs, the MSI data value
> must be unique per vector to ensure correct interrupt delivery.
> Currently, the driver fails to increment the MSI data per vector,
> causing interrupts to be misrouted.
>
> Fix this by caching the base MSI data and adjusting each vector's
> data accordingly during IRQ setup.
>
> Fixes: e63d79d1ff04 ("dmaengine: dw-edma: Add Synopsys DesignWare eDMA IP core driver")
>
> Signed-off-by: Shenghui Shi <brody.shi@m2semi.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..dccc686b7a3e 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -844,6 +844,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  {
>  	struct dw_edma_chip *chip = dw->chip;
>  	struct device *dev = dw->chip->dev;
> +	struct msi_desc *msi_desc;
>  	u32 wr_mask = 1;
>  	u32 rd_mask = 1;
>  	int i, err = 0;
> @@ -895,9 +896,15 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  					  &dw->irq[i]);
>  			if (err)
>  				goto err_irq_free;
> +			msi_desc = irq_get_msi_desc(irq);
> +			if (msi_desc) {
> +				bool is_msi;
>
> -			if (irq_get_msi_desc(irq))
>  				get_cached_msi_msg(irq, &dw->irq[i].msi);
> +				is_msi = msi_desc && !msi_desc->pci.msi_attrib.is_msix;

AI:
	Problem: Inside the if (msi_desc) block, checking msi_desc && again
is redundant since we already know msi_desc is non-NULL.


After remove 'msi_desc' check, needn't is_msi

	if (!msi_desc->pci.msi_attrib.is_msix) of below check

Frank
> +				if (is_msi)
> +					dw->irq[i].msi.data = dw->irq[0].msi.data + i;
> +			}
>  		}
>
>  		dw->nr_irqs = i;
> --
> 2.49.0.windows.1
>


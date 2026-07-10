Return-Path: <dmaengine+bounces-12333-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K6rYGuQlUWodAAMAu9opvQ
	(envelope-from <dmaengine+bounces-12333-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:03:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84C73CDF7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 19:03:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=H89fasaF;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12333-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12333-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B50AD3163A8A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FA813957E;
	Fri, 10 Jul 2026 16:50:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8399043FD07;
	Fri, 10 Jul 2026 16:50:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702226; cv=fail; b=pK4LTtZbbYpJAUrtn0o6ZOFN541YnPoKPV4WI2mD1euVXUWaGIDo7gDRN4S5Y58TcCN/GGK/aGZfWCPMYT8Vrrbnf8E5xLaCYMhckDtFjKLy649Y0zqbOfckPa53nFTYXYff8odhSv9ES7a2ElrQIjgvOi7Z/NpGLll+8bH4TN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702226; c=relaxed/simple;
	bh=rcjSSfBj1g69VjoH/BuKmW0T0whson4IPh1X7+0SB6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvnBEpM9OUd/hnLpdegzSTeLjw92u8EsGjghWLAkO+s5+VSnZtMfa+TaRnZt5y7iAl+CfiScvgAMbPG4MFF/mbGzpE1CXt/PYIDLr7hgYpqbs3mqIduBw6cjzgq+lR9UFtTm5Kop+lIMGwFJWZ3fmhSKoAYcs2DlGycTNWvvEWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H89fasaF; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyT8W3ll5uBJYR4ib7CwcK0kJesu+oFmdzRmA5W5H9nh6MYY0SRTsoqvXdb1lWcMvOupjLL14LbeSQqXTYjaSjn/qpt+vB4vVACx+H9L4Q8UWQ/qtU3HTrvWgOGi8VtFudOH95RrBL2swsXAU1divc/CAtns15+VE/k6/Incy0COtP/nVAl42oWVzSB0+XRLZc43b857qeLwKUs3H45uIk7PUwuVGeGpMkCsRt+LJzlGIktmDBY+dV02XHgL19ks2SjAkU1+zddCSdZegy8TEtnDv/69Sut2yHQQVFtdsQ+8Kidox9OEe0t/tr3DlOH8H7QGgLOicYn3WOJOYpfWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DsSwQEJmG09ntZAq6Nh+jSnpGUXjndZ2MGsSM0OKak=;
 b=sOgsuQTvLXbfhOJ3ySrpAgYZxbhvXy9/EjsLNmPjnIELP3Z2rdz7nP01zU4ON4+TK7aYVcrqd6UTuo/fYPfq32ZLvxG8LqmX08zR1uz+sDlpopxgpc26p3KGtHy1akCCB/Ye2OALoOfNl6uD5RF/XCTSdtweip2vK/IWofE9yRstInQysv3/dHbJqidsn2wpa5cxDYn1chrfhuqkFMWv+jx1+xtaZoO/XowgaF7m/QvcTAMdgS/BX1u+UUqMA0UcXrbzg0yPcv/0d6UGvbMWEOBpazZfwJmS6vRCpOG5hb+hkbK8ck2NabMENS4Vat51ji0r/zg3n1fvoNpDxKF4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DsSwQEJmG09ntZAq6Nh+jSnpGUXjndZ2MGsSM0OKak=;
 b=H89fasaFlhApjqfP+UROlk6SZZfF1PrcGt8oA4HGQjLrWw4IWrhCxyVN4C/0/v92lRRwQr+Y+K4xpe+lI3GuKsahQxR1IDJc2Ub7314Mevnwg7o6Zgt6byZNr2rCbbQUh1ll8efdafCPZ1LcmKJfqCvAizI64C31Xc1nL/ZPzRJjeng4IHbYQQy1KkTTet7m1sg9wm6m3VFYW4Z+kjYGI5RAhSZ943UQ9Tkt3+6kZEhnIRZgRf8G6LUBSeUI9YsuNbQtzlttXUk3Td8gFo8U2/JylFSXEZC+XD5GQ1/0cUeWR/za95vVHMjIgzo/ZSmrs8hyryRlSk43SiAJZxtdzw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 16:50:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 10 Jul 2026
 16:50:20 +0000
Date: Fri, 10 Jul 2026 11:50:08 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	Koichiro Den <den@valinux.co.jp>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 00/10] dmaengine: dw-edma: flatten desc structions and
 simplify code
Message-ID: <alEiwEChHTsoNJK2@SMW015318>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <1fad886d-9d69-4c73-b6d8-c1771c0a1075@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fad886d-9d69-4c73-b6d8-c1771c0a1075@amd.com>
X-ClientProxiedBy: PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: e61369a3-b0a0-494a-76ad-08dedea353b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	7gIJUee8NwB/WlgHBzCcS012z72hwaYkwNIcVoR1253vyQmSTKhs8YGq/yZF0vLeamcRtDfdfUpFQLWkOHg89v1YSXYuY0REHBSKga0sB2XLc1KI5miAhp6XyCwbENyHd/vZVZIoP49fQPufBU3U8F+BrEIpjAeyOQFL2Gkx2s4DPVyjmbuSRWdyic49rjxiFnskO59J9GP6C1J4YkKd9jfSxW2TUWQZN/jnaoxCK8cWtN1PtieBIYxvFrV70anjyDLdPltvAVU4p2n4XOcMDTR1Ot9Jv0xjRnzxGOY2y7gffYbpqYBOslze5ztSnsCXwPbwWmXFB78LZ+Sk3w8KEkYFGoHXa/vlodZtiB/TYQ3s1F+DnXVn6QjJc+KSEylhlaXmBMqvnZIc83huRVR/FHsfJ5H2t7CdZsLJJC20l7Aff1nGTBeavkhC0+yQG71T50nECC5y3KiHjxg1dbT/eOcrEtzK3UdayduIWW5HOj8p5cjIzpP3V5YaO/7kEwfqcLXow2bPPrpy7dfH2aJ7reX5qy27TOXgazLeMlEkPJWptAlBoZ0pu+E7dj11oJ9abpYnYyes5sgLfBgRlSgrPpAWR0QaA3Cnhieb6dqePbZmyf5X7SMKZbS06flnSewe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXFzeEdjSjFxQ2lVTCs4SXRFTWMxUW9nUnpkZU04STZUamJ4b1VGcFlnV09R?=
 =?utf-8?B?ZmNrSS9SSkkwc3k0RFBRc0JkK0dwREtUYlcvbHM1cDhOZ0h1bEs3TDVQYUxD?=
 =?utf-8?B?OFFFR3BDdmhUY2ZRdndKZTFtdmtUMGRuZ25wWm9admZhTElGQ2hWSXlYNFBN?=
 =?utf-8?B?dGM0ait2WXNIY082TUQvMXJPQXEwK3ljQ3J2RzBYZEEvU2JFUEN5VHcrcFFu?=
 =?utf-8?B?eUtKT1dwZkRMajdaVXYyaTJuTi8ra3NUTUNzcnkzbnRuQmZXamlQU3FEUk9y?=
 =?utf-8?B?WFYwendUQnJzbzhVUWZpcnhBbUFYaVQ0QVMyQjY4cU1GSGNaNHJSNnZMcVhL?=
 =?utf-8?B?Y042L001cCtCNFE3R3JhQzhUSTdNSlJrcUNCQWNYUHhBbzNhV3ZDTUo0bzlB?=
 =?utf-8?B?L1pnNzlLRVM5a3JjZE12dDNrWWtQMTNlR1RzWnNWcmdTYlJycU9aYXZVSTB4?=
 =?utf-8?B?NjNuSVU2KzI1LzVkMjd3R2JwVlhCYnBhN1hFV3djVHlCNDlJR05OVmlvc2NZ?=
 =?utf-8?B?S0d6V042eXhtT3FzdTdiQWRSZXB1UEpDS1MxRVZxajF2eDZSR2VkUHFncmMv?=
 =?utf-8?B?YjZrUi85bHNwb0tYTkRQeGVIRFZhbzdwYnVnZHZTdGhjeHYybVEvQzUxYlVS?=
 =?utf-8?B?Y1pIK3gxTGN6K2xyMktMZ3RISG1ZV1RxQ2xkemJNNUlFb05XRlNIQlp2YVVq?=
 =?utf-8?B?eE4xQjVrcEN5dnFmZVlmSE8waVBWeWhMMGYvUjJTVFIxVGRDdllucU55VnJI?=
 =?utf-8?B?eHorM0pqU2x0OGR4aWI2K1FTS1FqMWdyRVhiZ1l6Wk5lZVZyVmMwQ0syWGF3?=
 =?utf-8?B?bFNZemhjU0FpMGxyVlBJRnVvdmdFTjNFZmd5N0Z5MDNtd0NwLytDbjVvdmNs?=
 =?utf-8?B?cHZQU05HcG1DN1FRMk53cGRWd0R4MTh1c0Vmc2NKRURQNndCbWJCbHkxcEhh?=
 =?utf-8?B?Y0x0TW9yVDNCS2VUSTVtbEZrWVVYanduZXQzRWtsT05yL3hVVnZZZ25XUjFx?=
 =?utf-8?B?OFBJYzdUKzY3cU5aU01ISGNhT1pUK1BrV2FRVWtZZjh1Tkd6QXhUSXBhTVlH?=
 =?utf-8?B?MFlITnhUN3d6cUI5RHhWMFgrZGhLV3BKN0lFcFRUK1NnUWwrWEFQSW9HTEdV?=
 =?utf-8?B?S2J0aXo4aTBkcCt5MjY3djhGZzJ6a1gxSCtHTzBvbG9SQ0ZxcTlkZlpsQ1BJ?=
 =?utf-8?B?eURKSUhnUkNlSmxHYXl6QkM5Um1xVUVJTGowTnUwMnhOL201OUlVWHFJOHVW?=
 =?utf-8?B?T3RVVUNVRTZxREloY2laWHJ6V0ttRmNSS0JBTlZ6czl4dUtTQzArWDBhME5y?=
 =?utf-8?B?c2RadjBlQlpSQXd3U0hKaklVL2RmOFdlb1BSRFQxOWtnS0lQSG5sTDZsYVVR?=
 =?utf-8?B?b1piVmNTRUdoYlhUSUpGTU1BcHZJajRmUUNVQmJaUDNKVHBiRTNLNStZT29V?=
 =?utf-8?B?K2swNGNhNFk3QkRURGswKzRpUFBUU25oR2p1RnJKcHMxS1dIMm5HeVFMK0tG?=
 =?utf-8?B?T1dOT2l1ZU1sTHpBYlpUVDJiaXFza3lwWU8zMy92RVBPaFZXclZsOE00WHk5?=
 =?utf-8?B?eHRKTVF5QkFVTXhjOE9ZS3lwOWxXcG1GUk1VOUZlLzhHQ05rWDBZRWtLQ3R3?=
 =?utf-8?B?NXJwTTJXZG9kaFNOay9jeDNBMEUxR0hMZ3NiNzdkVUVwY29Od2gwN2dYVE5q?=
 =?utf-8?B?T0ovRHJXYUNPekNscktlSVdpNlpCSmhwcU1ub0d0MUFqNlc1Sm5qcjFqbnc0?=
 =?utf-8?B?cTZNVHc3SkE4c0grdlhvVUNNRDdRaFVlR1FrcFJlOXF2eHNmZHFxVFFudnRE?=
 =?utf-8?B?RlVQdUJpTjVzTVdyNWgyOGhGSklsL2VkK0l3eXhCWHZyU3ovZUxmNnY4NVBD?=
 =?utf-8?B?ZWRGMmVBU1VwQkhRRkF4cktLWFNjTk5MbkU4QmF1SzFUSlRwT3AySjExVFVN?=
 =?utf-8?B?Y095MVp5NWhtQmpLMVVuOEk2QmpTdlIzMWJEN1BsZmNCYWVRLzNSMFY1RU11?=
 =?utf-8?B?dEVwYWwwN1ZrZTJDdmIxVkR0ZXZFNmJWU2xrZ20zUjFXeVVVbDJqVlhwUEFm?=
 =?utf-8?B?SFdoRUc4NFMvcTVSOWFpclV2NGZwR3p4V3c2dkZHNFdUYXZTMHdGOUFuWmkv?=
 =?utf-8?B?dk00cTFPejE3ZjM0d2t3U1JLVVIwM0xJL1Z6NGFEdldxV21LSHp6UFN0b0k1?=
 =?utf-8?B?VEorZloydmhrd0hjZ3BPM1haSkRaSkVnUWxCZFR2VXAyaVJMYWVkY2tsK0JB?=
 =?utf-8?B?V0gvMnJJZVJFWSs2cGx6Y29GYlFDZURTSklqQ0lyeGpHbFliS0w2M2phV3Ur?=
 =?utf-8?B?R0p0dWw0OHVTNU1LbWFQdnRpdUxVWjdZNXoyZzArWk1xeDZRczdrN3NmZGt4?=
 =?utf-8?Q?ZcE0S9gj13wEwGpN031a4zx5sGQBxKSKCzofz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61369a3-b0a0-494a-76ad-08dedea353b3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:50:20.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHFDElt7xNQUiTpJF+V6dwKX/L/uGiJt0bwvzBKymVrXDZ+7s43iR1wuHsd1mH+X7LqewWuBaryfIq+0TL3r0Ff1bdu4/r0ieF6TVu5dKsICkB3zkJcvl/gF9jLHmYll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8574
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12333-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:devverma@amd.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,amd.com:email,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC84C73CDF7

On Fri, Jul 10, 2026 at 10:15:24PM +0530, Verma, Devendra wrote:
>
>
> On 09-Jul-26 21:03, Frank.Li@oss.nxp.com wrote:
> > Verma, Devendra:
> > 	Can you help check if block non-ll mode?
> >
>
> The current patch series is tested for non-LL mode.
> The testing included varying data sizes for transfer and running
> C2H (Write) & H2C (Read) for a specified duration on all the 8 Read
> and 8 Write channels.
> non-LL code works fine with this patch series.
> Tested-By: Devendra Verma <devendra.verma@amd.com>

Can you post at v6 again, Sorry, I just missed this email during prep v6
for sashiko report problem.

Frank

>
> -Devendra
>
> > Basic change
> >
> > struct dw_edma_desc *desc
> >         └─ chunk list
> >              └─ burst list
> >
> > To
> >
> > struct dw_edma_desc *desc
> >              └─ burst[n]
> >
> > Flatten desc structions and simplify code.
> >
> > I only test eDMA part, not hardware test hdma part.
> >
> > The finial goal is dymatic add DMA request when DMA running. So needn't
> > wait for irq for fetch next round DMA request.
> >
> > This work is neccesary to for dymatic DMA request appending.
> >
> > The post this part first to review and test firstly during working dymatic
> > DMA part.
> >
> > performance is little bit better. Use NVME as EP function
> >
> > Before
> >
> >    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6660, BW=26.0MiB/s (27.3MB/s)
> >    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> >    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >    Rnd read,  128KB,  QD=1, 1 job :  IOPS=914, BW=114MiB/s (120MB/s)
> >    Rnd read,  128KB, QD=32, 1 job :  IOPS=1204, BW=151MiB/s (158MB/s)
> >    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1255, BW=157MiB/s (165MB/s)
> >    Rnd read,  512KB,  QD=1, 1 job :  IOPS=248, BW=124MiB/s (131MB/s)
> >    Rnd read,  512KB, QD=32, 1 job :  IOPS=353, BW=177MiB/s (185MB/s)
> >    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> >    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6241, BW=24.4MiB/s (25.6MB/s)
> >    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.5MiB/s (101MB/s)
> >    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=26.9k, BW=105MiB/s (110MB/s)
> >    Rnd write, 128KB,  QD=1, 1 job :  IOPS=780, BW=97.5MiB/s (102MB/s)
> >    Rnd write, 128KB, QD=32, 1 job :  IOPS=987, BW=123MiB/s (129MB/s)
> >    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1021, BW=128MiB/s (134MB/s)
> >    Seq read,  128KB,  QD=1, 1 job :  IOPS=1190, BW=149MiB/s (156MB/s)
> >    Seq read,  128KB, QD=32, 1 job :  IOPS=1400, BW=175MiB/s (184MB/s)
> >    Seq read,  512KB,  QD=1, 1 job :  IOPS=243, BW=122MiB/s (128MB/s)
> >    Seq read,  512KB, QD=32, 1 job :  IOPS=355, BW=178MiB/s (186MB/s)
> >    Seq read,    1MB, QD=32, 1 job :  IOPS=191, BW=192MiB/s (201MB/s)
> >    Seq write, 128KB,  QD=1, 1 job :  IOPS=784, BW=98.1MiB/s (103MB/s)
> >    Seq write, 128KB, QD=32, 1 job :  IOPS=1030, BW=129MiB/s (135MB/s)
> >    Seq write, 512KB,  QD=1, 1 job :  IOPS=216, BW=108MiB/s (114MB/s)
> >    Seq write, 512KB, QD=32, 1 job :  IOPS=295, BW=148MiB/s (155MB/s)
> >    Seq write,   1MB, QD=32, 1 job :  IOPS=164, BW=165MiB/s (173MB/s)
> >    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=250, BW=126MiB/s (132MB/s)
> >    IOPS=261, BW=132MiB/s (138MB/s
> >
> > After
> >    Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
> >    Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
> >    Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> >    Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
> >    Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
> >    Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
> >    Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
> >    Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
> >    Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
> >    Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
> >    Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
> >    Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
> >    Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
> >    Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
> >    Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
> >    Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
> >    Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
> >    Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
> >    Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
> >    Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
> >    Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
> >    Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
> >    Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
> >    Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
> >    Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
> >    Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
> >     IOPS=266, BW=135MiB/s (141MB/s)
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v5:
> > - Fix cover letter typo
> > - Fix double subtract found by sashiko AI
> > - Link to v4: https://patch.msgid.link/20260708-edma_ll-v4-0-cc128f0afb61@nxp.com
> >
> > Changes in v4:
> > - collect Koichiro Den test by tags
> > - use addr in argument when set ll address, found by sashiko
> > - fix iterate burst problem when exceed max link list, found by sashiko
> > - Link to v3: https://patch.msgid.link/20260702-edma_ll-v3-0-877aa463740c@nxp.com
> >
> > Changes in v3:
> > - remove patch dmaengine: dw-edma: Remove ll_max = -1 in dw_edma_channel_setup()
> > - rebase to vnod's dmaengine topic/config_prep_api
> > - Add non-ll-start() callback to handle non-ll mode transfer
> > - Link to v2: https://lore.kernel.org/r/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com
> >
> > Changes in v2:
> > - use 'eDMA' and 'HDMA' at commit message
> > - remove debug code.
> > - keep 'inline' to avoid build warning
> > - Link to v1: https://lore.kernel.org/r/20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com
> >
> > ---
> > Frank Li (10):
> >        dmaengine: dw-edma: Move control field update of DMA link to the last step
> >        dmaengine: dw-edma: Add xfer_sz field to struct dw_edma_chunk
> >        dmaengine: dw-edma: Move ll_region from struct dw_edma_chunk to struct dw_edma_chan
> >        dmaengine: dw-edma: Pass down dw_edma_chan to reduce one level of indirection
> >        dmaengine: dw-edma: Add helper dw_(edma|hdma)_v0_core_ch_enable()
> >        dmaengine: dw-edma: Add callbacks to fill link list entries
> >        dmaengine: dw-edma: Add non_ll_start() callback
> >        dmaengine: dw-edma: Use common dw_edma_core_start() for both eDMA and HDMA
> >        dmaengine: dw-edma: Use burst array instead of linked list
> >        dmaengine: dw-edma: Remove struct dw_edma_chunk
> >
> >   drivers/dma/dw-edma/dw-edma-core.c    | 218 ++++++++----------------------
> >   drivers/dma/dw-edma/dw-edma-core.h    |  65 ++++++---
> >   drivers/dma/dw-edma/dw-edma-v0-core.c | 240 +++++++++++++++++-----------------
> >   drivers/dma/dw-edma/dw-hdma-v0-core.c | 169 ++++++++++++------------
> >   4 files changed, 304 insertions(+), 388 deletions(-)
> > ---
> > base-commit: c9e9927c6d8346cdf6555a8f97da093980172e4b
> > change-id: 20251211-edma_ll-0904ba089f01
> >
> > Best regards,
> > --
> > Frank Li <Frank.Li@nxp.com>
> >
>


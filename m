Return-Path: <dmaengine+bounces-8878-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLJ3HvNLi2mWTwAAu9opvQ
	(envelope-from <dmaengine+bounces-8878-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 16:17:07 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4911C656
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90B263017008
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8BE3806A1;
	Tue, 10 Feb 2026 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BhOIKF+1"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24897328B48;
	Tue, 10 Feb 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736623; cv=fail; b=lsDX6MYkPzfkqjygb21v4/BLvltwfAVPFoGMazXCOs+AyNcPZxOqrj4p5/CCeJ5fEeXA54JrJVllGGW+h4cffyOBH/ZEO2l5xmQZoIhHxig/RphLjYxYyktfSTU4ulUjwLYB6OIVu91M2Rb2BAXteejzTi41y8WHmSyTMxD0cpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736623; c=relaxed/simple;
	bh=s9vdvjj9mGtQEiVgApf3z3iubrCVoNQmn8ZZi/VMi2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s59bPGe70IWaSYN1KCV8TWwbypevk/zTDsv61tAtqlcgSsM1MJVyteOhG+7Yn2LAxuiuYeNe+pBJrOfzaGgLVWifz2BHBlZZUHKXzhjJ4z/0/YKKhhu/w0ZcZ3huZoCM9fRMn15rFAxT2xzf5TkIcQ+7RSIWJSR8/9K/FqdtfVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BhOIKF+1; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HT0P+aVNIpurFNwzD+gMK1M8Vmyzmkev1oVuYgtona00kP6hzXUb08b+WLdcBFPug9WcsTsNQJDiZk3ZcAu82ewqPgg6bQ8Dd/Odk9wW9umNireb6W2XSTtktPW5h/L2hh0ty4roQFw48KyUd1a5vMa5snuHaoEa1J9MEYbwCcQpPoQ83CbrK4XVg8qzPdbflXQ9C2IKxRxPh9lTA+NzxTQYSOOeNnlRSUuMo6qHs7df44BejyKQLKMJj8g1TlS2gTsIaAIwYDqPBP/EtoBxMekO3OWm1PnCjKFinJflg7xZgSn+w8mi4iUr1lKh4FTzlnonhxxtfVNrscvf0yPsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iASX7VG9NZ0wlnzPgQ+XrJNDBzt9Dq0MXzKumyrFC5M=;
 b=F1O4gHRnItdFcV+k9f8dfjsXGori3wLZoWP++nAu8M5zaT22nHCsBPwepRdjoap26Zt+4geoymhxtsLB13UyuXNwkIWIWI3nFLwSb2GByLua0PJwoZnElSOmmULxEult2dmqXRpNKNFqgmGPrUGw35QmPd7Tb3ivsC/y9wz2iwBGVQGTSa8M3VLNjC+J2yTW+Tg+YQjVdWvr7d1G4yiMExlg8RGbMod8reVA8VvNphIUSgVRK5MWCrOU1OtbirW8ogI8cifHVLf5/HUc+sdYz90mzyVWkPbRYCJpAvSmf1xeejRw1cNY44wVQQwj/FH1GUoQS4cTew71t6B7hx+QeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iASX7VG9NZ0wlnzPgQ+XrJNDBzt9Dq0MXzKumyrFC5M=;
 b=BhOIKF+1FUpfh3lQoHgYvAX77Db9MwpOWepp/J7XFfO+Ph1VlBAfJOEV+GAUWQ6fmrH3AXllxBbh7ufQgJyu7HO82m8DyBTizhvsqAUJYhGbvTOK7n3EK1Mea3hZm+uVmJdT0/6B8mYafEmqSZ0nJLmhCj1Vi2uduIYWD/Nhg/91JkSnIS8JLkCrmTh3ccO1gqrXkI8f4mfEzJBPe6+2YOloV5n7+R6NcxHXyCSvVOa37HDemViIdxuxHKdvl7LISTQGbxMJ6clvymRmd/YhXm2iWyXJcPVRm65K5DMgxEO9gDrQCk0fiZq/euABFUAtZdr0cw53hSVZyIKiAAYWFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB8001.eurprd04.prod.outlook.com (2603:10a6:20b:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 15:16:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 15:16:52 +0000
Date: Tue, 10 Feb 2026 10:16:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <aYtL2rirSjQg7oMC@lizhi-Precision-Tower-5810>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-9-den@valinux.co.jp>
 <aYoCnEmXYWA0f6TH@lizhi-Precision-Tower-5810>
 <ikrvjztquqyxqxnarna5iscixq42jx7jz5r2y34xxyao4ltv3y@7jds64xkzkj3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ikrvjztquqyxqxnarna5iscixq42jx7jz5r2y34xxyao4ltv3y@7jds64xkzkj3>
X-ClientProxiedBy: PH7PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:510:174::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 33107b1c-8a9d-41c3-0883-08de68b76b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oM7JdiZOvY0q3UXvLH1rQZsozXr6dBPu9SkjMEiGY/pdoaCDlFqzCZa7fwfD?=
 =?us-ascii?Q?wpAwf6qbFId8gv5dWQnqlWJXi404uCc5BUb2QGsSX3zoDLMRB65nCwaHRNWk?=
 =?us-ascii?Q?/VQK50AyghTCD90lnQK18425bMAnp2+jhG2iUsxfbm9p3ZvLaYHk8TofuxXJ?=
 =?us-ascii?Q?IX51E0A4qtDwdNLdI7uT4C46J0JNaEKcnKz8AGcPpCcM9dMq9Ro6/f5nzI+l?=
 =?us-ascii?Q?01q19/IJh9hSxjccMz+obTPZTK9hWTMNIWcGPb1hRDEP4c9XTJRRHTo4YEEO?=
 =?us-ascii?Q?1F9QJli4MEEcv/6gUoZ50HUp9DH2bVNPWki3BgmAkuhAUnfgDDqd6LlSP7rN?=
 =?us-ascii?Q?96Ao3N4dlulyhMFRUjxABEecbg0tNf8SKrlhl2WPAHtRwFJm3/8TAxKL61zT?=
 =?us-ascii?Q?fdP0o2tZgvQMKsGzub4c7CkQABobsRQCnwoFxITEWBo6h0lc7XMdaE8K6o1u?=
 =?us-ascii?Q?37Zb+6UBBcegAjMbXUcPvezLN1k097ajV2v5GHL3/8tGb3zqUWMvaYEgDPJQ?=
 =?us-ascii?Q?hb2Ej/o81Is8r45mSvwo/yF02+Pww3Qgcqxi7sQ3rfWIniweMd7otkvUgEkB?=
 =?us-ascii?Q?PkbyGP2NFWqN0yImb55BrtHW+c7eS1gBbVC1vFwievcuPAFjweWozzykD8e/?=
 =?us-ascii?Q?7m2Xti4Rz8qoeuc7JRWdVrIH+BKt5KFpsP+cVxR6PPa5xljtF3hf9pmbAyuI?=
 =?us-ascii?Q?vOdMSC0uA5+dlzBa05HZPsohD0GHhPoTn2qN+YwWquG9CLa7KM9iCIvhGO8p?=
 =?us-ascii?Q?Zy6IrEqhND7AwIIAE4trcKE1lgQHNJUNOrsHPPUuJW3hvJCwD53VwHVzzGBY?=
 =?us-ascii?Q?MgZoMc8VU+kMjGfEeIv9kztYkGTucPaA2tdjNrWW8H0PQvFIZ1V7DoDX70ks?=
 =?us-ascii?Q?opSpXMygbCAhciAPN9ra+L15EKcBM6AKSfRYtpFMJkPwhCQUMgF+7gwHfj40?=
 =?us-ascii?Q?6mrjCNzztiX0rTZiQZ//CE1Eh044SOH5qQS8rMYj05nSdLewmDVdSEbXESAE?=
 =?us-ascii?Q?FNPzwt/udKVmNrQ7+aTa1IxbiUrii8oa7dhz5VskPf7ld9Z2fAKZ+faDl5yN?=
 =?us-ascii?Q?bqUW6BBFVynO51WvHrpJioQD2i6KujljCAkNr7d2TO/z7FC45JGQRdXdkgH1?=
 =?us-ascii?Q?W/oGBLF3WGzW76c2FPiKslhMmOJWk/npjLSTis5pc6aZZNsbFYpNZ3wlmvGl?=
 =?us-ascii?Q?HB+1Hqz2XSET5zaazC+EJ8/icuGXbm7cB4+eueI4JBnpVHjwTo1mZ9s6zf2c?=
 =?us-ascii?Q?SPe4WD7/iXqdt6RL7dNfe12qegPPgdXLCjmIzVRULuio4syWwkfF/o0mjN1K?=
 =?us-ascii?Q?XabN3BYVufpa+uDSC2mCnKNKVjL186Q4vNloClTHGguOZYH/1kH7t4skwkyQ?=
 =?us-ascii?Q?TPr8428qafA8zqRcPcuquRLc3mIuOr5MbqhNqh4Y6HR4B+L9FeN4XaE7lAcD?=
 =?us-ascii?Q?VYvxXTJadpi79OMTgTgIsf9dVzYBAMvOV63JRI0sNmIgQd31c0xiuBt3qMqQ?=
 =?us-ascii?Q?MPowtLfidTkA16yrWiw1jq6/tihnHsX/Fg8ZJEQOox+U3tpCwXA2AZ0IJrR3?=
 =?us-ascii?Q?b/LbwmZ8YZ9k6L9MfaVMfDpJNSKtMz81//R7pl6KclG36oasq8+OXgPlzY+b?=
 =?us-ascii?Q?p3yvT9C99m5xx2WJc37i1sI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xoUyxbijErmwpaEqfObpqaSohPWdqt+H2xYfjp335sRc28e8lM+Bl9CFfP2?=
 =?us-ascii?Q?QNN/EPb9OlIm4NsxJxAGxVsHpuZTrPJxpYw7nNMmg7jg2OCcvHO2gqn5Mja3?=
 =?us-ascii?Q?xNGeAMydPQYMB0pNlKyA2LiFvJH7zrGFwP9PQuKXz6/5oPx6MyEubZmVRGwr?=
 =?us-ascii?Q?1rZ7H+qTgOYcjIP9upy8dwd4OrSr2I28frvfZX3MPyDFBkslToaMd7W5f9hS?=
 =?us-ascii?Q?Gu2rqGBnH5Q9+ArQS5YpQEHcOAWkDKYLvVHf8yoUDwuK+eRyUYjADAy4DjHL?=
 =?us-ascii?Q?oaZLv8ujuZdUTGoThfrzRIzu3jKUKlHhPHKdnOk0+5X55oY4RDykn57Pcm8Y?=
 =?us-ascii?Q?9/Rc061NxEDI7ooRfZhVAHSgUxX0paetuy2krVHYy64zJajtSStPz6hGnck3?=
 =?us-ascii?Q?VYGIOD8TD6TTpgL+EHwYj392FTd5rUYyaso+aW5GQ4rqNgR1sbSRhhm2ZwNu?=
 =?us-ascii?Q?8+dPYfK562bdPM7dBHlIuNjf8/f8rx7JSN8Ww8kMxLmyGZVsbmodtSD8IX64?=
 =?us-ascii?Q?WrKRL4+WVN3AzwnG4Cke5+aiCrzpqQmyx2w4aYmBFog48bsJqylxTu5c1jny?=
 =?us-ascii?Q?SGlimN3h3XWWVv3hJGA5rZ0Es1XJW4faNqrHbPEKEjpnxNXur/I0QtT4jiek?=
 =?us-ascii?Q?P/DH5PI/LaeaW4GAjoV1HJVDvuFiFtd6RtMucKIgXH0jByY1SBhDhak434mM?=
 =?us-ascii?Q?wMugIvN7aSRwHXHGdF0pQBl85+9IQdPAOcGtAzUAGZRCAHPyLtHQjEbtu1nx?=
 =?us-ascii?Q?yJgzW+rWtCdb+VWkH3coAQNKn5YcSDDomYz+4A5J0aBb5IoxCmA1TLX2Hd+0?=
 =?us-ascii?Q?I4DN5AjgnecyZcPpVtlr4rtA2V58A92Lc4uugY5OBoTNUOoYb73zfIakQxIZ?=
 =?us-ascii?Q?+WvfmTlvXayTSmnPQlFRX22Jk7sHIj1UYjdy0djQ5mbRrcWBx/gfLwHz8uTw?=
 =?us-ascii?Q?kU/kmSjj30Qd1oTCmvioe+CcSZDFdpMyVu+yEPsqjrvkv1ExZd62Dtsq7jKM?=
 =?us-ascii?Q?HZsD9tkd2cinNo+weE4tv40668Rsx45GMlV8xVgIZOR76SyOpguqgFrrcWbi?=
 =?us-ascii?Q?jXJRblsyUvc95WlY1PHWQfyVVqoTMk0H1ivSqEmLjYCs273oA5w3n4YRFZA0?=
 =?us-ascii?Q?9VlJ0Kn08lJIL90I8FQ2KiEDa4FjMPkaEnE7dvS630bwaDbpG1y1D5jQQ22U?=
 =?us-ascii?Q?/CdTWzy/zl4dexewFHXznBW2bxOIF4PoQagpUs+ThhtdrzHBmPkjrI17vNdE?=
 =?us-ascii?Q?cC5zY7uw5vPsAvw/j36e7DWuGYP9WyRwITFkibfW1ezmAma491qSalwE6yVN?=
 =?us-ascii?Q?cDqwNznDIRySYK7lpc1MXustbFar1AoCEYWMaeomkU5vpvqUAiotcjkn97qU?=
 =?us-ascii?Q?b0IbuKbtsNSkMbkXBCGaKT4MkAVt3mm99M/wv9TXCIKmtvkGBRlSMTZaONhB?=
 =?us-ascii?Q?pqN8OFsIeUtMxsRxhfB+XoTBoZPFFwjVe3ZY2bViqZMKGBZPUqNaxjonxk9u?=
 =?us-ascii?Q?zhUIbeV6ZMkbQc26uv3MXdVg/7WSeP5uTtRp09mIZfNbyDDY+vhQty0ryAyK?=
 =?us-ascii?Q?ncOTO9F0vvadaUTx2ISQAzk0IiKaCUAEEIk/ZO/0tJnlNRVUW9c/GUeCUxxW?=
 =?us-ascii?Q?FfDy2coy+gEko0aKxlEPgYuyf//hy3NlSpbRyPYvBPYAtOxVGs3S8d/ir0Sm?=
 =?us-ascii?Q?GNRhXWopvxA9RvVMe47GaYNi3KVSlNi4PbDj6sETXbbIPNItYHHey/OMoWyw?=
 =?us-ascii?Q?J8R2a39+Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33107b1c-8a9d-41c3-0883-08de68b76b25
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 15:16:52.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiSD4MVHP3RSwXw8pvARf3BDpeU3QqHsgcIwkzydJxR+6cIFKnZsvk9G6rNcQHbWGimINV2DBX+ZhY1jzE+kPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8001
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8878-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: E6C4911C656
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:10:52AM +0900, Koichiro Den wrote:
> On Mon, Feb 09, 2026 at 10:51:56AM -0500, Frank Li wrote:
> > On Mon, Feb 09, 2026 at 09:53:16PM +0900, Koichiro Den wrote:
> > > pci_epf_alloc_doorbell() currently allocates MSI-backed doorbells using
> > > the MSI domain returned by of_msi_map_get_device_domain(...,
> > > DOMAIN_BUS_PLATFORM_MSI). On platforms where such an MSI irq domain is
> > > not available, EPF drivers cannot provide doorbells to the RC. Even if
> > > it's available and MSI device domain successfully created, the write
> > > into the message address via BAR inbound mapping might not work for
> > > platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
> > > mapping does not reach ITS at least on R-Car Gen4 Spider).
> > >
> > > Add an "embedded (DMA) doorbell" fallback path that uses EPC-provided
> > > auxiliary resources to build doorbell address/data pairs backed by a
> > > platform device MMIO region (e.g. dw-edma) and a shared platform IRQ.
> > >
> > > To let EPF drivers request interrupts correctly, extend struct
> > > pci_epf_doorbell_msg with the doorbell type and required IRQ request
> > > flags. Update pci-epf-test to handle shared IRQ constraints by using a
> > > trivial primary handler to wake the threaded handler, and update
> > > pci-epf-vntb to use the required irq_flags.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |  29 +++-
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c |   3 +-
> > >  drivers/pci/endpoint/pci-ep-msi.c             | 129 ++++++++++++++++--
> > >  include/linux/pci-epf.h                       |  17 ++-
> > >  4 files changed, 160 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 23034f548c90..2f3b2e6a3e29 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -711,6 +711,26 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> > >  	return IRQ_HANDLED;
> > >  }
> > >
> > > +/*
> > > + * Embedded doorbell fallback uses a platform IRQ which is already owned by a
> > > + * platform driver (e.g. dw-edma) and therefore must be requested IRQF_SHARED.
> > > + * We cannot add IRQF_ONESHOT here because shared IRQ handlers must agree on
> > > + * IRQF_ONESHOT.
> > > + *
> > > + * request_threaded_irq() with handler == NULL would be rejected for !ONESHOT
> > > + * because the default primary handler only wakes the thread and does not
> > > + * mask/ack the interrupt, which can livelock on level-triggered IRQs.
> > > + *
> > > + * In the embedded doorbell fallback, the IRQ owner is responsible for
> > > + * acknowledging/deasserting the interrupt source in hardirq context before the
> > > + * IRQ line is unmasked. Therefore this driver only needs a trivial primary
> > > + * handler to wake the threaded handler.
> > > + */
> > > +static irqreturn_t pci_epf_test_doorbell_primary(int irq, void *data)
> > > +{
> > > +	return IRQ_WAKE_THREAD;
> > > +}
> > > +
> > >  static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> > >  {
> > >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> > > @@ -731,6 +751,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > >  	u32 status = le32_to_cpu(reg->status);
> > >  	struct pci_epf *epf = epf_test->epf;
> > >  	struct pci_epc *epc = epf->epc;
> > > +	unsigned long irq_flags;
> > >  	struct msi_msg *msg;
> > >  	enum pci_barno bar;
> > >  	size_t offset;
> > > @@ -745,10 +766,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > >  	if (bar < BAR_0)
> > >  		goto err_doorbell_cleanup;
> > >
> > > +	irq_flags = epf->db_msg[0].irq_flags;
> > > +	if (!(irq_flags & IRQF_SHARED))
> > > +		irq_flags |= IRQF_ONESHOT;
> > >  	epf_test->db_irq_requested = false;
> > >
> > > -	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> > > -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> > > +	ret = request_threaded_irq(epf->db_msg[0].virq,
> > > +				   pci_epf_test_doorbell_primary,
> > > +				   pci_epf_test_doorbell_handler, irq_flags,
> > >  				   "pci-ep-test-doorbell", epf_test);
> > >  	if (ret) {
> > >  		dev_err(&epf->dev,
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 3ecc5059f92b..d2fd1e194088 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -535,7 +535,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > >
> > >  	for (i = 0; i < ntb->db_count; i++) {
> > >  		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > > -				  0, "pci_epf_vntb_db", ntb);
> > > +				  epf->db_msg[i].irq_flags, "pci_epf_vntb_db",
> > > +				  ntb);
> > >
> > >  		if (ret) {
> > >  			dev_err(&epf->dev,
> > > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > > index ad8a81d6ad77..0e93d4789abd 100644
> > > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <linux/device.h>
> > >  #include <linux/export.h>
> > > +#include <linux/interrupt.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/module.h>
> > >  #include <linux/msi.h>
> > > @@ -35,23 +36,84 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> > >  	pci_epc_put(epc);
> > >  }
> > >
> > > -int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > > +static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
> > >  {
> > >  	struct pci_epc *epc = epf->epc;
> > > -	struct device *dev = &epf->dev;
> > > -	struct irq_domain *domain;
> > > -	void *msg;
> > > -	int ret;
> > > -	int i;
> > > +	const struct pci_epc_aux_resource *dma_ctrl = NULL;
> > > +	struct pci_epf_doorbell_msg *msg;
> > > +	int count, ret, i, db;
> > >
> > > -	/* TODO: Multi-EPF support */
> > > -	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> > > -		dev_err(dev, "MSI doorbell doesn't support multiple EPF\n");
> > > -		return -EINVAL;
> > > +	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > > +					  NULL, 0);
> > > +	if (count == -EOPNOTSUPP || count == 0)
> > > +		return -ENODEV;
> > > +	if (count < 0)
> > > +		return count;
> > > +
> > > +	struct pci_epc_aux_resource *res __free(kfree) =
> > > +				kcalloc(count, sizeof(*res), GFP_KERNEL);
> > > +	if (!res)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
> > > +					res, count);
> > > +	if (ret == -EOPNOTSUPP || ret == 0)
> > > +		return -ENODEV;
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	count = ret;
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		if (res[i].type == PCI_EPC_AUX_DMA_CTRL_MMIO) {
> >
> > I suggest use PCI_EPC_EMBEDED_DOORBELL_MMIO directly because some vendor
> > have really doorbell register space.
> >
> > below addr is that phys_addr + res[i].u.dma_chan_desc.db_offset. So vendor
> > can easily change to their doorbell register space in future.
>
> That makes sense. I can extend enum pci_epc_aux_resource_type with a
> dedicated doorbell MMIO resource type and use it, instead of assuming the
> embedded doorbell lives inside the DMA control MMIO window
> (PCI_EPC_AUX_DMA_CTRL_MMIO).
>
> With that approach, I plan to drop u.dma_chan_desc.db_offset for now, since
> it would always be zero in the current dw-edma v0 case (the INT_STATUS
> offset is not channel-specific). If another vendor implementation needs a
> channel-specific offset in the future, we can just extend this again when
> it's actually needed.
>
> In short, after your feedback, I'm thinking of the following change (diff
> against v6):
>
>       enum pci_epc_aux_resource_type {
>       	PCI_EPC_AUX_DMA_CTRL_MMIO,
>       	PCI_EPC_AUX_DMA_CHAN_DESC,
>     + 	PCI_EPC_AUX_DOORBELL_MMIO,

Yes, thanks

Frank

>       };
>
>       struct pci_epc_aux_resource {
>       	enum pci_epc_aux_resource_type type;
>       	phys_addr_t phys_addr;
>       	resource_size_t size;
>
>       	union {
>       		/* PCI_EPC_AUX_DMA_CHAN_DESC */
>       		struct {
>       			int irq;
>     - 			resource_size_t db_offset;
>       		} dma_chan_desc;
>       	} u;
>       };
>
> Thanks for the review,
> Koichiro
>
> >
> > Frank
> >
> > > +			dma_ctrl = &res[i];
> > > +			break;
> > > +		}
> > > +	}
> > > +	if (!dma_ctrl)
> > > +		return -ENODEV;
> > > +
> > > +	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
> > > +	if (!msg)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0, db = 0; i < count && db < num_db; i++) {
> > > +		u64 addr;
> > > +
> > > +		if (res[i].type != PCI_EPC_AUX_DMA_CHAN_DESC)
> > > +			continue;
> > > +
> > > +		if (res[i].u.dma_chan_desc.db_offset >= dma_ctrl->size)
> > > +			continue;
> > > +
> > > +		addr = (u64)dma_ctrl->phys_addr + res[i].u.dma_chan_desc.db_offset;
> > > +
> > > +		msg[db].msg.address_lo = (u32)addr;
> > > +		msg[db].msg.address_hi = (u32)(addr >> 32);
> > > +		msg[db].msg.data = 0;
> > > +		msg[db].virq = res[i].u.dma_chan_desc.irq;
> > > +		msg[db].irq_flags = IRQF_SHARED;
> > > +		msg[db].type = PCI_EPF_DOORBELL_EMBEDDED;
> > > +		db++;
> > >  	}
> > >
> > > -	if (epf->db_msg)
> > > -		return -EBUSY;
> > > +	if (db != num_db) {
> > > +		kfree(msg);
> > > +		return -ENOSPC;
> > > +	}
> > > +
> > > +	epf->num_db = num_db;
> > > +	epf->db_msg = msg;
> > > +	return 0;
> > > +}
> > > +
> > > +static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
> > > +{
> >
> > suggest create patch, which only add helper function
> > pci_epf_alloc_doorbell_msi().
> >
> > Then add pci_epf_alloc_doorbell_embedded.
> >
> > Frank
> > > +	struct pci_epf_doorbell_msg *msg;
> > > +	struct device *dev = &epf->dev;
> > > +	struct pci_epc *epc = epf->epc;
> > > +	struct irq_domain *domain;
> > > +	int ret, i;
> > >
> > >  	domain = of_msi_map_get_device_domain(epc->dev.parent, 0,
> > >  					      DOMAIN_BUS_PLATFORM_MSI);
> > > @@ -74,6 +136,11 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > >  	if (!msg)
> > >  		return -ENOMEM;
> > >
> > > +	for (i = 0; i < num_db; i++) {
> > > +		msg[i].irq_flags = 0;
> > > +		msg[i].type = PCI_EPF_DOORBELL_MSI;
> > > +	}
> > > +
> > >  	epf->num_db = num_db;
> > >  	epf->db_msg = msg;
> > >
> > > @@ -90,13 +157,49 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > >  	for (i = 0; i < num_db; i++)
> > >  		epf->db_msg[i].virq = msi_get_virq(epc->dev.parent, i);
> > >
> > > +	return 0;
> > > +}
> > > +
> > > +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> > > +{
> > > +	struct pci_epc *epc = epf->epc;
> > > +	struct device *dev = &epf->dev;
> > > +	int ret;
> > > +
> > > +	/* TODO: Multi-EPF support */
> > > +	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
> > > +		dev_err(dev, "Doorbell doesn't support multiple EPF\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (epf->db_msg)
> > > +		return -EBUSY;
> > > +
> > > +	ret = pci_epf_alloc_doorbell_msi(epf, num_db);
> > > +	if (!ret)
> > > +		return 0;
> > > +
> > > +	if (ret != -ENODEV)
> > > +		return ret;
> > > +
> > > +	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
> > > +	if (!ret) {
> > > +		dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
> > > +		return 0;
> > > +	}
> > > +
> > > +	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
> > >  	return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> > >
> > >  void pci_epf_free_doorbell(struct pci_epf *epf)
> > >  {
> > > -	platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> > > +	if (!epf->db_msg)
> > > +		return;
> > > +
> > > +	if (epf->db_msg[0].type == PCI_EPF_DOORBELL_MSI)
> > > +		platform_device_msi_free_irqs_all(epf->epc->dev.parent);
> > >
> > >  	kfree(epf->db_msg);
> > >  	epf->db_msg = NULL;
> > > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > > index 7737a7c03260..e6625198f401 100644
> > > --- a/include/linux/pci-epf.h
> > > +++ b/include/linux/pci-epf.h
> > > @@ -152,14 +152,27 @@ struct pci_epf_bar {
> > >  	struct pci_epf_bar_submap	*submap;
> > >  };
> > >
> > > +enum pci_epf_doorbell_type {
> > > +	PCI_EPF_DOORBELL_MSI = 0,
> > > +	PCI_EPF_DOORBELL_EMBEDDED,
> > > +};
> > > +
> > >  /**
> > >   * struct pci_epf_doorbell_msg - represents doorbell message
> > > - * @msg: MSI message
> > > - * @virq: IRQ number of this doorbell MSI message
> > > + * @msg: Doorbell address/data pair to be mapped into BAR space.
> > > + *       For MSI-backed doorbells this is the MSI message, while for
> > > + *       "embedded" doorbells this represents an MMIO write that asserts
> > > + *       an interrupt on the EP side.
> > > + * @virq: IRQ number of this doorbell message
> > > + * @irq_flags: Required flags for request_irq()/request_threaded_irq().
> > > + *             Callers may OR-in additional flags (e.g. IRQF_ONESHOT).
> > > + * @type: Doorbell type.
> > >   */
> > >  struct pci_epf_doorbell_msg {
> > >  	struct msi_msg msg;
> > >  	int virq;
> > > +	unsigned long irq_flags;
> > > +	enum pci_epf_doorbell_type type;
> > >  };
> > >
> > >  /**
> > > --
> > > 2.51.0
> > >


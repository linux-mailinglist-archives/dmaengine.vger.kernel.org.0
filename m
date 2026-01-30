Return-Path: <dmaengine+bounces-8621-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJpuGizQfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8621-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:37:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF062BC153
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B6BD3039889
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97F3382DC;
	Fri, 30 Jan 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XRbeBehR"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893993358B8;
	Fri, 30 Jan 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787407; cv=fail; b=Z+kqXUiUYUlolSnEDwgmLf1urQXsEI8J0wzL40mZhVudiPisYxdhmq3uuktjsK7fc8ldcYnoN8dPs0eenyl0cjGzMHLH0V4CDrAJp8WnJpGrSy8ac7pAqbk5qtrCFxeDUg/gA4eyaPgjKRNRdhwL50an+m4hcaXAB/G1SyCc/nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787407; c=relaxed/simple;
	bh=cCgXgdgFmEiJ5TtEl4KmC719jrFs8ecCZJXuWOGRafw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H2tVQZZT9DFPv/+pKg3UMJKySB9o4pRkJKpG+alR8WhL6r7z72kWhUpx7YiCU2EFP2MbV/1Z3Tw1CsmeubE1xgH5+zFLQV7rdezJD8lJbxDRAeWQadWLZxDrxG44QcKuXznFC5EiDAiavrTY6HhtKwHGv5PWd1Q00vFwi3ilKVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XRbeBehR; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGF8PARyhqoDhUQfh3wEmAyD60Z92fJOXimHdHe12FptJlam0sBdyNzmU1bV72hQGOMtZRqRD+f5Yy8+VgOM3/0fTCh0XpoRZM2rOIB+5FgIWnYKsYtZaKCmlVddTUIoty43sUSe5V7VC3MGHvviLp0dlN0aJGZqcXc/SZ+M26ThNALpPbP7amqnv0raUiFbbsODzfROIFA+i9tIVQ2QJJRyLKu6argDAvDjvLFRapeRpuH3TBU3xaRLvDlhWIBxmZvi7ZQaOq8KcVWe9brZjDHwFI7Of3O4lBUiQpYrYNP5n1GI+NtARQV6XquEFnTrtreJAqROnFhfvRCzXuyuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB334Jx8Wj24ySRAczvLwNrshoT3QRNsEFF16auvqNQ=;
 b=x1YGwboceR3q90PfXhmHa9fFWRZdigJ3wfIFUiN+JULl9MH+6rDRtWYMBR+52wKy0TNzje2v5KKUKoyEc8QLTq+/9SGA3AQq/lOjYh90NGjLtRa7GvpiiqDC9gWK+24oH4qUVO20HG6lmqYS89ZEiJTeVx9DqJtKKBO6aqTC3bXHrIQay+90/HN5ZTOhsz9eDMABuMLHV76wFDIXnJ7yoampKsum13n8Rd5DQzWtfCGcRC0gYzHsoaSoo3xWQ3xg3xTceNdgnCofuBpDz6QDLzmTQ3Wll2Mm0Fo3fbE0SqOcUm3hMYx/MNcp8CgRu8EwYmWQq1L1OCcqoWd3+arasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB334Jx8Wj24ySRAczvLwNrshoT3QRNsEFF16auvqNQ=;
 b=XRbeBehRwbfUZdts33W7PaPRHALj6V6ESbMQukZ69LxOBrCDCZqu5O2YQViybwyrxocdN7sSyE0wXf3EtJhyUCYEZEhk382xOs5AbN5DxaS2Ckgt/hlgaskveN2zGQNWGi6PClWMSuL/teTsR4i32gtfuOiCP2Zf4mo07nFSfYOwpZU5lKXuKrwkr9OHQE5NlRNZeEZ99qZjmpNd7MrToduEOhptYdNUvriJB+jwpnLh2jPqguE1pws5J3Dv/4CtFwAwAE0xbqFsWgXiuwDko6cQKfKEuNzUKlo2rQxiBbVWgfDD4WkUbWG+t2RWK6z6MAXqPU8Zg+AzCpqMl1aXWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI1PR04MB9811.eurprd04.prod.outlook.com (2603:10a6:800:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:36:42 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:36:42 +0000
Date: Fri, 30 Jan 2026 10:36:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 01/19] dmaengine: ti: k3-udma: move macros to header
 file
Message-ID: <aXzQA1a3DVz2Jmcg@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-2-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-2-s-adivi@ti.com>
X-ClientProxiedBy: PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI1PR04MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: c190315f-23ed-4a54-d68f-08de60155e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iMr7qehUrSTWOMB5+R2S+N8YFTzlbWypgwU7RPkMeAE7KMGMUO/3M2VTPm9f?=
 =?us-ascii?Q?xfYM3AYzORgPCKVRPPlwIzA9PP31kk9lgBiMAkTF2Fa1f8Ew0jy4n9GTPU+5?=
 =?us-ascii?Q?jBeQ/K/lM6cDwySi+W7DKkZfWoHdI2NxXuQsvMj/5QIn2g/ctXezvlThm1hR?=
 =?us-ascii?Q?aQF68fBLVNmHoF07XHsY0zzT5q5GPbcuQXEhRHLgJlBxa7pvXfDPyrbT7cUB?=
 =?us-ascii?Q?pPrp97X1opoxhp4yUCMum/iLsG3kop6diSdsyfngczsdNgmeI/bVdPubwKg1?=
 =?us-ascii?Q?dzYgcmPwgWTgZvDaqUvdeKekvA7DpyJ715iEySOAm0QLyo2TJBbC8vbduNxD?=
 =?us-ascii?Q?RaWvPPlxKSU/6GyGhi5Y9GKs4zgwqKssTMrzYJuxYiEIWBiUr3feZMCzKE1s?=
 =?us-ascii?Q?LwYyHniI/qpbIr92vlsKa3Zh21Moej0Tm3jhnt2KZrMyYCCbihHh+/ArDJWt?=
 =?us-ascii?Q?7rApXfo9H2/vREWvf1oHY5+dQchONgOmdiPJkaikC+bU5Cvj1GJTI/icUdUn?=
 =?us-ascii?Q?pgAWbNMEUkE2EnWU6uIEbb2YwhWmgFWlvqAfbTN7zzmr9z/gQRC4HqRShA1l?=
 =?us-ascii?Q?PbSmah3dARECNttaYR0m+uwyKtRccHjTocy4rfcXYOoJvoB5gnzkq5BXTzIu?=
 =?us-ascii?Q?OIT56ZIOjLUkZr8oi2poFTUWh+Ww+gfu+eesrivZIdbQf1azX+qrrP+EafX6?=
 =?us-ascii?Q?E4bvsbS9Hp/BJYRAhl0A0NOErRZc4O3SxZ/sA7/dNexinB+Y/CK41E98Exb8?=
 =?us-ascii?Q?bYvpSIY4G/ze+ngRUywGqOOHggnZaOqRnkaAXfGLkK3WTJn414xWS8vsgcR7?=
 =?us-ascii?Q?R7sQ1u465aehvp8OV9P4DXOkAkM7ket7RsTSif68dG9QnJqY6cFm4/Pw5P1n?=
 =?us-ascii?Q?iJzlveU8llfbYDrw2HCOvXkMwKiwPsOqrtrMASgckR9PWQvZKpkzsg+iy1FP?=
 =?us-ascii?Q?jBhuhcR6B5crmffyPwARQEnKslG0bNk/zRH9zguqWLPQo1bwMuQ2w6FqDWoZ?=
 =?us-ascii?Q?r03vxK9/Zojt8KI7d4opf1fLPp+tWdoChlTvdIMYVOkhNmjm/LkA8yCNOUIV?=
 =?us-ascii?Q?+htHVa5eCtmMAvL8PIfnYFeIDAERbokFfwczP8i+GAGyc/EXfCsKDzTA7BvK?=
 =?us-ascii?Q?ZJ+qUHzFXVoBUd6yBvzFmPJm6aLyb++t3dIgCmy4TM+p2Jrg4ibjwowQxUgk?=
 =?us-ascii?Q?Rt2qaRHLSR8S4FzUsPaj+62XPlowTBW3Oc+EgyKkedv0HXe/qk0U8L+x91kM?=
 =?us-ascii?Q?2RQDkTdYuBoCG41sBVs+9GQLjowixOktw2gjbpjGQmbdPccxB9CY+RkE4Ljk?=
 =?us-ascii?Q?eU8qSfBnsBTPfX/go8Iwfzmh2wkj2BDitxoSte78JVq1i7hMht1PKrUgD1wY?=
 =?us-ascii?Q?PmoOOZC+hNCf5sJYQbHEqNA5DJkcAUHkOC+3/Xp1sBKyS77w1+jpJTaZnkto?=
 =?us-ascii?Q?Uzg2EyUv9nk2DHDBCHPXehRTkxvIwxOreZelP6wmxmjKhc/nc82qA2sq4n9L?=
 =?us-ascii?Q?pZhJBs/OxG7TBo84Atx08h/7TPEs9eTdnnHm9ogIPtAjqqBeuYe6CE4qXx/3?=
 =?us-ascii?Q?0u5Zvt12qghRa1nKmiNzSi00aAoPVLgUySZsIlJb9X01TD+DCpVaXCs8KWWs?=
 =?us-ascii?Q?FsRRJ77SV1t+ejZeO5kZtio=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mg+WWV4+cx6ql+TECw1t9ON516EW+m7/2Imv4P5ECHg1R1iazaw9+31Qr61v?=
 =?us-ascii?Q?Dn/ECGsxBfznqviVRR7kC175JwzkOXZX7gl7IsUu0oOUqze7cGs/yQiWx6xJ?=
 =?us-ascii?Q?gM4wnk3T4UjichU3bedZxH/Jbk7Zf7WJEAH+fVarMZQYhCxAgYp0T796mml2?=
 =?us-ascii?Q?4GzuPRwKSCubHiEA6e7Oh8RsRGx6bAXN7VckTWUrAXdm0dFbM7y32Aa31IBI?=
 =?us-ascii?Q?wrRjEgQcEwIWl/ImS47x1BGWNFxByFzniGCFU4qmDACmyhls1r9+QOpkv7dY?=
 =?us-ascii?Q?XB9+n3+jpB5AAG9YENa82rvRQ+U3IUpyGspkENDUcT1Du2vj6r3B1SjwcZ9z?=
 =?us-ascii?Q?lbyhg1ecdxODpq64zhKuvNbejwYAJ6cDBem9T5q1MzWhQjW4v1CRE/h3EM/U?=
 =?us-ascii?Q?B4vl/TtQxLUBNXRxB9l++UST6XocOJz1N4PSQgGmser694Teg5lbEBqhIO3T?=
 =?us-ascii?Q?hC2NFWYxNK4YGFQ0c2Ryze0xYxtvUPJp/Nwn06a1DDM/zv984trDprqjr/Q7?=
 =?us-ascii?Q?mopzuTfDDuBPvSotgmzCGTilxS7O5HL6o5VR+Tpiswqg1aEaiDNUVfNMH1Bp?=
 =?us-ascii?Q?CuTuKU+YlbBCAdj+VMm0Sq4UtzhB/Fr8687bCqNphP+ujxm+7CJD8Qvcr24L?=
 =?us-ascii?Q?iL0G+GFYCW/RsIVVuvYVoyEhanNRKWCRml+a2vn8oHXlyjRm/vxBw6cNpo9S?=
 =?us-ascii?Q?YJ2iMlZ8y5/JnaVV7GPW9EFzjlEPAfeojku+071aFIPKiRCBwIZsJyUqufiv?=
 =?us-ascii?Q?9n9iKHrSSsGXeNIkKxFwOKsJUdyKfYRj2Y5WNuy84H4g7IFLpg6Jz8gpVs6E?=
 =?us-ascii?Q?0vidwt8GRvGwns+X0+pHtS332EGDHNI0QmaNm/QbIdjo4LUFShVjRkbmIddz?=
 =?us-ascii?Q?0TpdSh0ajdqZMElUetXEIjO38rBYEE67EMZHoRU+tiWBgK3t8/qFSn3Vpbo+?=
 =?us-ascii?Q?j/TXbn+5mZOoxBfjfyMs0a6S0bxVe34oXZUsE13Hl33IDctppssxA06OFfm2?=
 =?us-ascii?Q?3nks8GraPGAVaWFvKjFElDOWGjpaIRqHR3O0QfrNTTC8ZBJW8l6L/zW9IyLL?=
 =?us-ascii?Q?J6QMl1yqBkzT+06v5GcRM4N91EKKQKReQyzlMSSJ6nIJ1P72ZnQ3EFcbAuCp?=
 =?us-ascii?Q?pL6WMVG63Hxty8c6udrSmJ3Yam0L8HvSjo+I+8OVgOaMQ9r5L8YNjnVbDJhE?=
 =?us-ascii?Q?PkxNP4pFJIkataC5e3jQUWR7BV+NAfK9UbQAO1rpMzDEXW4IT82CLB0NuMyy?=
 =?us-ascii?Q?K/s20wLFjTLVrJr1io8Xcp6t+bDylCmczq8Cs1LDMhOuLwFq5rMbrRGXzInW?=
 =?us-ascii?Q?J89JtrqBHCUTJc3vJjF4R0gJNiA1dljpsFHZ3soZ6hzC1IfP7gjU7Pms75mg?=
 =?us-ascii?Q?qVc9MGcuoPI0HrhQrkJlDeXGVNIaD1d7D5zcwZ3O2y0vJ0IRKNyJR0y4cUkC?=
 =?us-ascii?Q?gA48bGLVmdkHg4cjTzm1WZJU9c/voSTvDbQtCrQWOzAdb36Ng3Kt/nko/VxO?=
 =?us-ascii?Q?emnv3vUTFBR5w/XJytCQxImN1HKsINZGhsw21v3cz1/yU9eE7cgJtYabNpxA?=
 =?us-ascii?Q?qNH5Kl7IwyYZ6mpvUtdo6q4CT3ZysQ1HMtWatjcUf5PEvERO+jgUZi6uFdBZ?=
 =?us-ascii?Q?JnD/0dJONEokT3Vc2iNTKpo30nsLmaU6II/A6TdLtNLHP+ylAwjIebbyHrut?=
 =?us-ascii?Q?IgiIzB1BvFhiS0HNh6OSzMJz/uf+N8Ers/aswag2/AeQrrXQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c190315f-23ed-4a54-d68f-08de60155e39
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:36:42.6909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxLos5H79ULOhEy8s0VpwQp5QtAqEmlaewg47zeGcX6/TMY1fQElpOC9QAU+KdTV4wdrHJ0u3orLPE5RU3DwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8621-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF062BC153
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:41PM +0530, Sai Sree Kartheek Adivi wrote:
> Move macros defined in k3-udma.c to k3-udma.h for better separation and
> re-use.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/ti/k3-udma.c | 62 ---------------------------------------
>  drivers/dma/ti/k3-udma.h | 63 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index aa2dc762140f6..4cc64763de1f6 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -39,21 +39,6 @@ struct udma_static_tr {
>  	u16 bstcnt; /* RPSTR1 */
>  };
>
> -#define K3_UDMA_MAX_RFLOWS		1024
> -#define K3_UDMA_DEFAULT_RING_SIZE	16
> -
> -/* How SRC/DST tag should be updated by UDMA in the descriptor's Word 3 */
> -#define UDMA_RFLOW_SRCTAG_NONE		0
> -#define UDMA_RFLOW_SRCTAG_CFG_TAG	1
> -#define UDMA_RFLOW_SRCTAG_FLOW_ID	2
> -#define UDMA_RFLOW_SRCTAG_SRC_TAG	4
> -
> -#define UDMA_RFLOW_DSTTAG_NONE		0
> -#define UDMA_RFLOW_DSTTAG_CFG_TAG	1
> -#define UDMA_RFLOW_DSTTAG_FLOW_ID	2
> -#define UDMA_RFLOW_DSTTAG_DST_TAG_LO	4
> -#define UDMA_RFLOW_DSTTAG_DST_TAG_HI	5
> -
>  struct udma_chan;
>
>  enum k3_dma_type {
> @@ -118,15 +103,6 @@ struct udma_oes_offsets {
>  	u32 pktdma_rchan_flow;
>  };
>
> -#define UDMA_FLAG_PDMA_ACC32		BIT(0)
> -#define UDMA_FLAG_PDMA_BURST		BIT(1)
> -#define UDMA_FLAG_TDTYPE		BIT(2)
> -#define UDMA_FLAG_BURST_SIZE		BIT(3)
> -#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
> -					 UDMA_FLAG_PDMA_BURST | \
> -					 UDMA_FLAG_TDTYPE | \
> -					 UDMA_FLAG_BURST_SIZE)
> -
>  struct udma_match_data {
>  	enum k3_dma_type type;
>  	u32 psil_base;
> @@ -1837,38 +1813,6 @@ static int udma_alloc_rx_resources(struct udma_chan *uc)
>  	return ret;
>  }
>
> -#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
> -
> -#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
> -
> -#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
> -
> -#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
> -
> -#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
> -	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
> -
>  static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>  {
>  	struct udma_dev *ud = uc->ud;
> @@ -5398,12 +5342,6 @@ static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
>  	}
>  }
>
> -#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> -				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> -				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
> -				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
> -				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
> -
>  static int udma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *navss_node = pdev->dev.parent->of_node;
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 9062a237cd167..750720cd06911 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -97,6 +97,69 @@
>  /* Address Space Select */
>  #define K3_ADDRESS_ASEL_SHIFT		48
>
> +#define K3_UDMA_MAX_RFLOWS		1024
> +#define K3_UDMA_DEFAULT_RING_SIZE	16
> +
> +/* How SRC/DST tag should be updated by UDMA in the descriptor's Word 3 */
> +#define UDMA_RFLOW_SRCTAG_NONE		0
> +#define UDMA_RFLOW_SRCTAG_CFG_TAG	1
> +#define UDMA_RFLOW_SRCTAG_FLOW_ID	2
> +#define UDMA_RFLOW_SRCTAG_SRC_TAG	4
> +
> +#define UDMA_RFLOW_DSTTAG_NONE		0
> +#define UDMA_RFLOW_DSTTAG_CFG_TAG	1
> +#define UDMA_RFLOW_DSTTAG_FLOW_ID	2
> +#define UDMA_RFLOW_DSTTAG_DST_TAG_LO	4
> +#define UDMA_RFLOW_DSTTAG_DST_TAG_HI	5
> +
> +#define UDMA_FLAG_PDMA_ACC32		BIT(0)
> +#define UDMA_FLAG_PDMA_BURST		BIT(1)
> +#define UDMA_FLAG_TDTYPE		BIT(2)
> +#define UDMA_FLAG_BURST_SIZE		BIT(3)
> +#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
> +					 UDMA_FLAG_PDMA_BURST | \
> +					 UDMA_FLAG_TDTYPE | \
> +					 UDMA_FLAG_BURST_SIZE)
> +
> +#define TI_UDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
> +				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
> +
> +/* TI_SCI Params */
> +#define TISCI_BCDMA_BCHAN_VALID_PARAMS (			\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID)
> +
> +#define TISCI_BCDMA_TCHAN_VALID_PARAMS (			\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID)
> +
> +#define TISCI_BCDMA_RCHAN_VALID_PARAMS (			\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID)
> +
> +#define TISCI_UDMA_TCHAN_VALID_PARAMS (				\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_EINFO_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FILT_PSWORDS_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
> +
> +#define TISCI_UDMA_RCHAN_VALID_PARAMS (				\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_FETCH_SIZE_VALID |		\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CQ_QNUM_VALID |		\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |		\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_SHORT_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_IGNORE_LONG_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_START_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_RX_FLOWID_CNT_VALID |	\
> +	TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID)
> +
>  struct udma_dev;
>  struct udma_tchan;
>  struct udma_rchan;
> --
> 2.34.1
>


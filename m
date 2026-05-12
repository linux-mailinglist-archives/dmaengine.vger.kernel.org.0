Return-Path: <dmaengine+bounces-10383-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNQeLM2RA2ru7QEAu9opvQ
	(envelope-from <dmaengine+bounces-10383-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:47:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39123529857
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 22:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2537F30733E3
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F237E2FA;
	Tue, 12 May 2026 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cbsd1XDF"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41883AD50B;
	Tue, 12 May 2026 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618180; cv=fail; b=LjrgdptPuTO7pqTMYkDxyWN3E0wGpChqOLVAo7A0O5OMEAcDb8N/14BbGeQP5qS4ldcIwYy/qgx1p9cwOKDJAF/B8wC+2UG0TaT658++1wGhl6WLxW75yNFcr80HMA8lDUAA1p0UqZb/A7SCjL4j7XksRDRXTvFd6VYKHCXfsVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618180; c=relaxed/simple;
	bh=+Da1V5jBUnVn7cStStskBnW12HcC9dvQDbv7wjgaVpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HcgiPYlQYBzt0pmbTJHO6omWao4c68uTIA7hik78Q8MtNzHXYMgjB31n2fAsYrm+6kB4ryryVJKkMHF7438Vfs2XyZTB1JUBdU6s7gAsstvzfuoaH6Xno+nZ0RmagzKtCUcaS75o/9wZVWIzxY++LmCLfXMVyjy+27uopl5Kw6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cbsd1XDF; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIcGvrO3Vtv3QSDyADYiFhNpEE876zr8dg5KshMNvrRaux6ydmhxAOl6ZDlNv2mZRtyhN2NVewvZJZDrS+y7HIg3cK0GN/vmqR/iuzEPsKfN2zTC2hTY2L57v2GcgBZhzDHqhcEvoyZNUVGpDJPkTnwv9AsDrzt96zveWiJZy763R7ir8VNdcqQBpFHX7iwGIslDsD+V3TlMVbP3u5ZB9r+nPTWRsP2YNtU4PE0wz+HRZEQEh5S/9t9+6l0yIEokhe1U88uS5ZV1CN14i0Re14NYIiKxWjJ7DjympSDRFQzF+4occV0+Ci+wUAc0IsIO/djmfxoktLRDk60jGg13lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbXb+LAvGxcbgoUkN8uA3Y+OjJHzYEKodMJ0Spb+vzE=;
 b=R1IXKe3rYcbhMWTZzLzkwzb1H5YwrKd/gzfnaSKQ9GMUHRBXmnZNa1TIBfJC9QFySdgRCwCEFZ3Xc+xtobw++ep5hzFkyXXd/ygevii62STlVBwM1EXdlVT7Es8gEGR4UjNsG+8Xwzke9GIueFe21lMjRzPGgTz4NcRzln37vmDDbdKnARV4h4P2VFJd6Usf8NRpLeSmEEdBoHEkDYiE2SXL7/mY71FxLIJkcseAqx2FNtDivmfpfD4FvY6FdqZqp2HVjNGaMPiqBgPjs9ZdDPmZfBpwUR9n/tyTw++r/GhlGQZVkkFnQRoTWLGeU7lYmJhvtMVU58o6MU2LIAz76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbXb+LAvGxcbgoUkN8uA3Y+OjJHzYEKodMJ0Spb+vzE=;
 b=Cbsd1XDFuePHsK9bwbhto3jcqC5xxLWDpQPPy55I7Te/6ILADZlFkJmlCjzSxFcV0i7k6hLyncL6wQO5kz3hVBKdfuFIUp2BuyM0fPo8++sZhQNwghPnXnhyQuLvgs9oNKsjBZWy4TquFqfGZAcWqj/3MP7xu6CZvZiyu0rjUUU5qqOoB5MoLPY5UWWSkSuWaHuxGAkelHtffskabuOJpTbPJWmyl178gzJWHBYNWSMaAp2KSc/HyY0EyDHXz01bf1MMvlQh33MqeWYG+LACLK3ZIXZQbvwyBD93wgMZVCuRotk+6dB87j1/HGk6VM5ZjVGMPT0rjHmktcAbLAQEMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PA1PR04MB10142.eurprd04.prod.outlook.com (2603:10a6:102:464::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 20:36:12 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 20:36:09 +0000
Date: Tue, 12 May 2026 16:35:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de, geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com, kuninori.morimoto.gx@renesas.com,
	long.luu.ur@renesas.com, claudiu.beznea@kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 02/17] dmaengine: sh: rz-dmac: Fix incorrect NULL
 check on list_first_entry()
Message-ID: <agOPL-rdfePlvOtm@lizhi-Precision-Tower-5810>
References: <20260512121219.216159-1-claudiu.beznea.uj@bp.renesas.com>
 <20260512121219.216159-3-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512121219.216159-3-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PA1PR04MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d58f8d-d746-4803-4d33-08deb0661947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|52116014|366016|38350700014|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	pWLepgfFXZ+dToXpiTnAm3+b9K2xsGzLd80IN9fvL/xoNJrSbQ/Al+wbFcIf6umVg8ce6Pi8tsWbRo9UkKOqSzqUg7FCk3WfWwBrlFSe7xVpRJutAmheccKpekoAb7kkq6kn4APbDruoKIvmQ54Sm4hJ1OrG9pNRn+P+KoH6NkUn+tjYu029YglDv0R527zbbKakNZVa/ceUQ8PedL21ELDLPDZmbCpgkdXR2HuWg9i4I34raLRPnTzKHZdvHcMiMEvJE+1xCF//d1LVF6ZHdBNPiO6+YALc61uSGOEl0hxCG9l1L2eusaTPICL5187IKj8Op2fDvSp3M4T5zD0r3kfCB2sf9J/elDRgM36yUBDm9XKZBDM1/I7bJrsiSQusgn5utC9wxscU8KdHjnzV0aHzR9oYTeAlbcYtVl9KVEl8ORwDcvSNR9VYHtSFk+JSOkxDQtAaeaD94jfgAbAcpbEOEcL3eSC3VKOBRI8/TwoF5FrOdMqUX08FLOjsno0kSOlgWtcynW9HbhOdYfc0mhxpCVXU07JLKgMpIdVnHsCKlEM1nGQxmPLU7BVz0nOAwuf/7WhclOPjKcoqBZaGH+cR3o/DqPVgU7rh9lKUHtoeik0xVL43WpCSzZF4ETIHuZl1eHe1sPDdfTQyBdD6vVfirog6MLTdQy6MN9WgvdF2zDwW2Sqzce4NjlaZvjC0kh3ZuMcvq05hT1W6Ex6OVq7oQO5lP3FxE2m1mnnNfOC78fXhp0B5rd8lWM8xGReK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(52116014)(366016)(38350700014)(56012099003)(18002099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRyhx79eMEQIN78tM/FbFmTX9XG/DAdj5R3rzZTW5eMk+EYRypkDdWTXUzbM?=
 =?us-ascii?Q?tNB5K+3XlkCiaYqX9/GkdxeF6oZFR+4cIcDLrfQUUTlAUkg909vxccTZd/l9?=
 =?us-ascii?Q?+IMGAz/86ccruIBSRD/J191Di83NHUoyVScJuDNHJGFI5k8/9d8TOXbPzsXc?=
 =?us-ascii?Q?F7G73/MWQjyS3/5Utm5+b3J6V1upI/vztjoEvRhzUQZJ/IQjZ2WG3P2YLTyv?=
 =?us-ascii?Q?tiKznnq4i4UjnOQ30eTg1h0Sna+iZFYN4yVUXFyIPSqGT2bB212S8CgJFnM8?=
 =?us-ascii?Q?0VX3nNwAkwLePvLr/Ey2SCmYVGtReFMV7+cauiw46n0jyKg/I4TSld/d8gRN?=
 =?us-ascii?Q?F0Gya/j/hW2qa3aPXM5swqJekVfww0xaog2e+/3B4s90so8YRuYDa1BkgevN?=
 =?us-ascii?Q?xQ/TZNNmMwzvmYk6oHNhaG/j7loSyFK33mNQbVgVm6xhHlNqmuP7iOZqdpC4?=
 =?us-ascii?Q?cAyjj74ADDPVZT/sFT7ca02laM0i4g4OnfchpIF9EodRk1SPJ/gzZ/GbN8Dt?=
 =?us-ascii?Q?gkPHOZ5kGQ9KIAHLk+6vKP5gd4UehEoKnqIHoWk0kEPwZqu7zWUK5VECpNQk?=
 =?us-ascii?Q?N8e5EY72N3j8yV7XHio8zzRZ+Tk0ZHbh1aqSXPXWUEDVyZIJjhNpamYJwIlE?=
 =?us-ascii?Q?JQnpmN3WOAc2AqZ6N9vnkTcBmU99oCpXaJ+fbG5s9Bq8jh64u7PvaMHQU9Kg?=
 =?us-ascii?Q?w3DoQ9ypwQ+OV0COfQuFbPo48wJFCSjgmrGM+A6hiEiM/w2lFSA46VmCh0mS?=
 =?us-ascii?Q?KwArW6D2nxybsz5qvwkifbOAPD+KcswjAdMF/m4Is1h9ERvL4V09wBbRFeSg?=
 =?us-ascii?Q?U7cRZICr2DFqFcB0sO1EcUzW9GX8KuYhsMwOlU2YUzB5u4VZ3b9E1/pWV9BT?=
 =?us-ascii?Q?36F+vq+5MbnI1IHsE5kDXYCtkyNKxWjRe8WZLKpBWElWBJsMNkcWY5np7GHz?=
 =?us-ascii?Q?4gU3tjHYhADj0UZKKIVBjs/j2QY281n8QmQ5v9wDlAqPyT5MD95IQTSQQoF5?=
 =?us-ascii?Q?xMpLln7gCc6hJ5EfHgAnWj5hCeFanLW4zVm3QSTLQateRn6eeyBCwvnPCi0E?=
 =?us-ascii?Q?Sd4AlYiGvwNwK28xz/49go7beJ0+w6TPEbWVM+0VS0G0X+KOkXCC0/RFxvDc?=
 =?us-ascii?Q?2NPpk7yF+dnu554p/nJAKV2OXl1sFh/msBSFVJ7SnYBP1mo3vclARN5NDVxL?=
 =?us-ascii?Q?ELp8oFu8zpSlcdUJCxlC3t1qlU5+uOG4bc+XJSaNlI3GCuJLCzMw2noGD1nu?=
 =?us-ascii?Q?8xLjP4V7IEBbY5CgDz0kKDBwMCjsErD3nNIx7Y+WgFufcBkJLB/63zsMDk2W?=
 =?us-ascii?Q?oKo9hF3JNu0ngJR/M132Sug0vum9nGxyQI8Htmc0fSIs/KbaghsoVvLwdPOI?=
 =?us-ascii?Q?hhE08mAvK2OTuGagQeHpspQ0DUMxWVFVjByEdJ0dwAVLrBqUFBa6cQ/9xSy9?=
 =?us-ascii?Q?XjtCjnuWUuoJJK9HEQyw2mcz6yM0FBM2AZCnM5NP9wxCkunG1Uxe0Jenb4jq?=
 =?us-ascii?Q?OHPZkYiwj9kE+CjYvHAPG5z3W336OSMGyUDJP/6Dvka4mzfxu7b4yXuE/tBJ?=
 =?us-ascii?Q?wEjpfGWhyV498Q9eUjgOQoRn/oySP+B2JHKyNNT9BMYUhvvrTW6ZMoVJ1nv0?=
 =?us-ascii?Q?ZdQdzOOKG9YBXy1whlPKCbHsNB95r1qar5GKjVrhPl4nMV53KBtbzN5ZkFAA?=
 =?us-ascii?Q?VPC2d9QXRexJegJzqEKQyJED3ecJYDV7eD70dywCT+vmqvYo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d58f8d-d746-4803-4d33-08deb0661947
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 20:36:09.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01ULW3Xr5f+8JRFUHLzx/+TdyQzuy19JcV9IajjYpQmFDejNYRCkaGw/0Uvw64fAaSLDqI1qCusW8TPk8+vzGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10142
X-Rspamd-Queue-Id: 39123529857
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10383-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:12:03PM +0300, Claudiu Beznea wrote:
> The list passed as argument to list_first_entry() is expected to be not
> empty.

Little confused,

#define list_first_entry_or_null(ptr, type, member) ({ \
	struct list_head *head__ = (ptr); \
	struct list_head *pos__ = READ_ONCE(head__->next); \
	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
})


both list passed to list_first_entry() or list_first_entry_or_null() must
be not NULL.

The return value is difference.

Fix incorrect NULL check for list_first_entry()

list_first_entry() does not return NULL when the list is empty,
making the existing NULL check invalid. Use list_first_entry_or_null()
instead.

Frank

> Use list_first_entry_or_null() to avoid dereferencing invalid
> memory.
>
> Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

>
> Changes in v5:
> - none
>
> Changes in v4:
> - none, this patch is new
>
>  drivers/dma/sh/rz-dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 9f206a33dcc6..6d80cb668957 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
>  	u32 crla, crtb, i;
>
>  	/* Get current processing virtual descriptor */
> -	current_desc = list_first_entry(&channel->ld_active,
> -					struct rz_dmac_desc, node);
> +	current_desc = list_first_entry_or_null(&channel->ld_active,
> +						struct rz_dmac_desc, node);
>  	if (!current_desc)
>  		return 0;
>
> --
> 2.43.0
>


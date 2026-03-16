Return-Path: <dmaengine+bounces-9456-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKcoHxyZuGmsgQEAu9opvQ
	(envelope-from <dmaengine+bounces-9456-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 00:58:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ACC2A220E
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 00:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F0E73013C63
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE44379980;
	Mon, 16 Mar 2026 23:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lls+Af3u"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69637754E;
	Mon, 16 Mar 2026 23:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705494; cv=fail; b=rTHHY+ZtijbVIPvAtyeUKg6Z6t/ogyWh+6oWADNHLTbrJmiYnO1IbEuO7m091usvzAL79RACfCZI0RS0v/MS7I1oeQFNWeM7CXHLcbTLrKtYUljak7NrJPHlGOXeuzFQt+G05RvMclKvNdQxrSm2wafRF019I3bLXvNpMzgwS40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705494; c=relaxed/simple;
	bh=g/DL3VvSB+Zua6FFEjROjmoPWd+KdhEB0lS8mvml0BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eoaIlzfksaAVVEwffqNYkjTTfwxDt/dP+K44E8dkqzv0lQhj0V1izYfYrM/09cHsroBYIySk6BPoeweNy0KI98ZdA1N/1Qejf3/6tp4jDt7qVH4jWW8Bjnfuuf3UR5woZChFJZgbddBsJlz59jSX8TrJK24e5tvppI7bNCbkVVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lls+Af3u; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSxnBzS4LhZK+kKgWB4A/VZHfl5n1AZm21G4/NVT24eEXychG/R7SuIJqBaCGDALsYNrPJ+7MHAVjBnT+DdZhcBKc+OVOHrPNN9hLmyAfla4OF7C646C1VLCPadb51vrKxZHn0a4/L1ZWZimcO+Skq1amdnrRHq6NUTK7GswVe7KnDDE+pYwyKOyurdwE1Kyqlm427w3zKi28xO6CBi1mjAcxXBGmA3McwutOzyYnl6FgQq26zqzMOo2MkuV9CtsfGdik5l8Y0qgTFPkNEsemLo3Eq669SU2H63mmnWyyZGx7xRqRsk937f+uQlQa+k+Eqx32flyn8wn72I32UOp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRtvQ/coAfbHLlnNLK1BLpKtJpe3nr+YaDv9UyR8Lis=;
 b=doN6bHMUr89Do2nnxHB6Nc8reGu80fc1BQHKDTSh34yD3uPFFEg8jll4rMuJGeb9bTOCNEnCERQ2ECeauFJKNMY0iLyXpBdVPGea2+NxUBpgliLw46o9iHgxsBkyXb799gsOcYPXOQAsZ51gLStUyA/2ocXEHTfwws8jL9XETnOn5ThNDiPf0kxuCFHLN62lSgsK3YRlHwGJhEqzudnM3bMaUNsKFcdm17mzu1Lqg9wfkPdqBtyLlRSeuTepTW3HoMlDWMIKb+50b2KRTZ8NvsbcoF0cu9ShPPfLLD2iXWzWCi8EQXyrJuNOqhPKVJfB/6TM06QE3Mckc6Whyu7lQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRtvQ/coAfbHLlnNLK1BLpKtJpe3nr+YaDv9UyR8Lis=;
 b=Lls+Af3uoGgjoDuiiMPztwbHVPW4xaOWvAAko+iEB8z052+nkajEPGfGpCLxBDHA2pLYXNMfd3852gF/Knpc1ihhNBsHGzX2Wu0zKrt//nUIBYCNvawrtwGKMU1UN+XIe+B7ATmt9e9Jk2yyRTme+y+WS157Zyqo33rTgn0pxxsyG2n/fWzQBhE9012Fn6hFKQom4yxfOf/SrTKbzcbnOWOwVEc1RTnjDm9DGOeUaB7wLroN1uHpr39w3aNtNCRGDW/BhHdSJf8KvssBY4e8VuKge9XEsbjC/K3AsTCFnq49HQz4dKNjlwNP0mx4Q3Xf2SlPZQN9w9ZrweYBrbkH4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11834.eurprd04.prod.outlook.com (2603:10a6:150:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 23:57:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Mon, 16 Mar 2026
 23:58:02 +0000
Date: Mon, 16 Mar 2026 19:58:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com, john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Long Luu <long.luu.ur@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v10 7/8] dmaengine: sh: rz-dmac: Add device_tx_status()
 callback
Message-ID: <abiZCmeMC1IGKgMS@lizhi-Precision-Tower-5810>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
 <20260316133252.240348-8-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316133252.240348-8-claudiu.beznea.uj@bp.renesas.com>
X-ClientProxiedBy: SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11834:EE_
X-MS-Office365-Filtering-Correlation-Id: 10079c23-1423-4ead-22b2-08de83b7dbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2+2IJLMVOT6rf2sHEtPBggUfe6NSAeopYRc7yWF1Zk/zpLxeDv50I/wWsP9/Ki/Zqimxub4R/cUG5v9PlNsfvMhwj5Z/sNNUEmAs963FqD36nXDqN+vlFEsXUjEeGNrcF5MJLv/qcg+RZ6WBXPCZ5FmYMW9YwdB4DTHbRkZZsb/po/NUmgo4NaigToStOBDFKEZ0wvW+247gb6ketSasFLKniRJE04aYCJXa9s6/dOHiBX/LG4+vBVElRHJhAOdIdpQzJcgAShaUgwMHryiWdV0xQd/V9AfqGc7ofTfObQpRUTAwX/V7B6y+s3laIxOcDwW3jC9UEFuG3EN03lhOGV/18VSxYRUze4up/e+TCnQ/t1rXyd/8s9+tZuc80mRElzSMtGmJ9GbEZvYOju6cq35MF04Q+PyvPM+V1YdxwET2lTQkGeQBHV4yH99zpm4l2kdwQBF2mWFJxPsOL8ZG95IMKBGShzhBAGXRwdHG99q54oWKVsEN4HtNqGluHSN/haI5hJeVgjrzniKteKlU9/PaXfgdpKpmDvShE/vihAAKziD5g3aT2BguM5z5eMJ/vVJ+/NHQcK1oW0XK0hLLqSmGW7jO06MNW4MsdS9s7uRTGCCSHY+E8QosWV4U3u7/7zvUHYi8MucMxgxoo69RSfTGpF0BVl1k1ZCKBswtKNzvTWl/yW0WEzMo+NM4xsjID3gesXOKzqwM+18mMAOcBCXWLXVHQDN9Ud1S6eI94bIQQL3HV7Bpa6VQXy679M2jhXKMVVBVoPUjFUYTvTXURmIXrEhBmVD8Wdxj/x0zTEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhksz4rxPeOc/X3BABFj1/5w9WH0D2L6g+DBaohvUCpQemwaz+2V7u4D8tfm?=
 =?us-ascii?Q?aFWwO71uibpdxNYBdISAF4genvPI2TjQqFXFhbvgs2GG8DvPepspCjG1s5Xs?=
 =?us-ascii?Q?omEUcQJ59oH0fjOBpqKSGlwu/Blb+4HZ4gHYsOQ4J+RidFI2W91EgQBv1mMl?=
 =?us-ascii?Q?NgU5I5/diP+BkYXaXF97xAGl9XAYFQclkowTIEmV1q9St/n/pSGYKBGubB/R?=
 =?us-ascii?Q?fqr3QZtODLiTcaDKF22jgCj0xZZwnmmpqmYCdpZbiZkQPTpSFrk5ldHbsSOa?=
 =?us-ascii?Q?Za1tXFFzhWTxZoU0ENdu1tkf55iNARlV2BBKy49i3ZpvesprI2Kl+XPzFTiF?=
 =?us-ascii?Q?1cpbWdemlD3ViPjY9TnVVd3swLrhXBFfVzMptMsXUjXFmJ6dvdlIA6k/ruW6?=
 =?us-ascii?Q?kL5G1We/ebrWyCYmZkNYSJd+WI2w5xNqpYQm+UPdqjsF38TWDqUCUILAfkdx?=
 =?us-ascii?Q?PdhI8JbfZmG/ETChW8EhfgA37WaYZQpOe/LK1yTG0al1rGit+ZKDsWS0K+B4?=
 =?us-ascii?Q?YSXaaUhAktCc3HyZFB6IDgMz5t5v7329Hl1noOrLsFASca7JcUV0FDCfmxbx?=
 =?us-ascii?Q?CwpEXhmEP7UWTX5kGwGs1MT8ZcgYqfZcFIDgim1XIDAokbEizudNcWL309me?=
 =?us-ascii?Q?MF5HTAS1Ekg81x72wSSSKvJ7yaaSsMDWrLh7Kd41EVAcDd/iuLtZWfiiw8Fg?=
 =?us-ascii?Q?stWVBGFbTeFLtxovp571r9iaWwKRjuhoHPZ1apcT5u1CysPlvH2RHy5IYqmi?=
 =?us-ascii?Q?I4Elexq7qIA6RdicAZAhNidr1twgDBPF+AmnQ1lqA85P8d9cd7MhUeZ4jLEx?=
 =?us-ascii?Q?7Ze4Ld/sbWaarLJOcIvcTs/AN/0pKEhT9SJ//aTtb9iMgcwaWIfuMTqBNpLl?=
 =?us-ascii?Q?EaM2s8LqkEBEDt2WvH9mEQSlUsbzk9JJADaYpCXkN4waOsP9Mx1iNN5OEvaV?=
 =?us-ascii?Q?lh9h7SeH777ymMm9ssCCH+iBsaf8N+AGQ0kM0XHcGd6JQ7pzncLzYy7YmgHc?=
 =?us-ascii?Q?gZIbssl7XmSiRgLZO0bstsyZXjraTkclyk0QO7wayAJGBF0TGq4GSOhyLiLQ?=
 =?us-ascii?Q?hFo+jO1SOkiFe0JPdmDqmmgkkSISDE2cay14NFBP5AVikuHDCaCKXZECXF/G?=
 =?us-ascii?Q?CBoAMC1RXeTkBApMp3PMjw/4rSkMPg9KTQ55LXEaR7D5T51NQQwPzAdidkHW?=
 =?us-ascii?Q?tanGlDzn2uraVUC6hqhIG9tUIUMYnYr5i27oy/5doDxlCssbpqpHzhXLXRlh?=
 =?us-ascii?Q?+qj94oRmVH1NBHQYVGdlIN2quCHvwYu/t2gfctk6SX5otKtp4Ra4ILTi8dGk?=
 =?us-ascii?Q?AJIVY6hpv0JZBJU5Kpy7M1N7IwFE7GCutdvQzXxh4FmN0/VhC5Sx+ARAOs47?=
 =?us-ascii?Q?pJwvNKqgmFNBAbnmwifwbScur5PNwxAONyI6y2OTzz4gXSW3dhaMMhJFRg1S?=
 =?us-ascii?Q?LaJoAWaG859g7Q3WASdziKAId7dcPhix1n81whBZbrX6ddSDC/mUMnwHIg/A?=
 =?us-ascii?Q?m4uijY1unO9jsL2t+JLse5wcPBujstpyUTwzmk62kxRjVmgD/xtX/mao91O7?=
 =?us-ascii?Q?I2VyxbvTEPfmTMxSDkL0/D77eSt7egDpadEIuurqGbsn0LBbGtaT0kONGOYH?=
 =?us-ascii?Q?fDmtP0vmYzg/1eOIoCxPJ4whnNKr3Dg9ASBt3GZiCRNuFH0WxgkPdk9whzne?=
 =?us-ascii?Q?D/kdaePCxAkogCzPlvl9mwDQkIeu7FrfFEgJskvAdTbdjghQJctSS0IcmsWo?=
 =?us-ascii?Q?ucHx7MGMCw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10079c23-1423-4ead-22b2-08de83b7dbbd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:58:02.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQpEW+YJ0BJz/zbz08SDeDvqabzFDdWq9Y0C9A+f0Zox+IbwFCoAisk66NPIwHV/7wZ19fxSgQ6mAcm3c2FeRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11834
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9456-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 81ACC2A220E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 03:32:51PM +0200, Claudiu Beznea wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
> transfers and implements a timeout mechanism on RX to handle cases where
> a DMA transfer does not complete. The timeout is implemented using an
> hrtimer.
>
> In the hrtimer callback, dmaengine_tx_status() is called (along with
> dmaengine_pause()) to retrieve the transfer residue and handle incomplete
> DMA transfers.
>
> Add support for the device_tx_status() callback.
>
> Co-developed-by: Long Luu <long.luu.ur@renesas.com>
> Signed-off-by: Long Luu <long.luu.ur@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Changes in v10:
> - none
>
> Changes in v9:
> - adjusted the patch description
> - dropped contribution list for Claudiu Beznea
> - used Co-developed-by + SoB tags and included Long Luu in the
>   contribution list as well
> - dropped the read of CRLA in rz_dmac_calculate_residue_bytes_in_vd()
>   and use the copy from the calling function (rz_dmac_chan_get_residue())
>
> Changes in v8:
> - populated engine->residue_granularity
>
> Changes in v7:
> - none
>
> Changes in v6:
> - s/byte/bytes in comment from rz_dmac_chan_get_residue()
>
> Changes in v5:
> - post-increment lmdesc in rz_dmac_get_next_lmdesc() to allow the next
>   pointer to advance
> - use 'lmdesc->nxla != crla' comparison instead of
>   '!(lmdesc->nxla == crla)' in rz_dmac_calculate_residue_bytes_in_vd()
> - in rz_dmac_calculate_residue_bytes_in_vd() use '++i >= DMAC_NR_LMDESC'
>   to verify if the full lmdesc list was checked
> - drop rz_dmac_calculate_total_bytes_in_vd() and use desc->len instead
> - re-arranged comments so they span fewer lines and are wrapped to ~80
>   characters
> - use u32 for the residue value and the functions returning it
> - use u32 for the variables storing register values
> - fixed typos
>
>  drivers/dma/sh/rz-dmac.c | 144 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 143 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 6bfa77844e02..4f6f9f4bacca 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -124,10 +124,12 @@ struct rz_dmac {
>   * Registers
>   */
>
> +#define CRTB				0x0020
>  #define CHSTAT				0x0024
>  #define CHCTRL				0x0028
>  #define CHCFG				0x002c
>  #define NXLA				0x0038
> +#define CRLA				0x003c
>
>  #define DCTRL				0x0000
>
> @@ -676,6 +678,145 @@ static void rz_dmac_device_synchronize(struct dma_chan *chan)
>  	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
>  }
>
> +static struct rz_lmdesc *
> +rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, struct rz_lmdesc *lmdesc)
> +{
> +	struct rz_lmdesc *next = ++lmdesc;
> +
> +	if (next >= base + DMAC_NR_LMDESC)
> +		next = base;
> +
> +	return next;
> +}
> +
> +static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel, u32 crla)
> +{
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.head;
> +	struct dma_chan *chan = &channel->vc.chan;
> +	struct rz_dmac *dmac = to_rz_dmac(chan->device);
> +	u32 residue = 0, i = 0;
> +
> +	while (lmdesc->nxla != crla) {
> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +		if (++i >= DMAC_NR_LMDESC)
> +			return 0;
> +	}
> +
> +	/* Calculate residue from next lmdesc to end of virtual desc */
> +	while (lmdesc->chcfg & CHCFG_DEM) {
> +		residue += lmdesc->tb;
> +		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
> +	}
> +
> +	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
> +
> +	return residue;
> +}
> +
> +static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
> +				    dma_cookie_t cookie)
> +{
> +	struct rz_dmac_desc *current_desc, *desc;
> +	enum dma_status status;
> +	u32 crla, crtb, i;
> +
> +	/* Get current processing virtual descriptor */
> +	current_desc = list_first_entry(&channel->ld_active,
> +					struct rz_dmac_desc, node);
> +	if (!current_desc)
> +		return 0;
> +
> +	/*
> +	 * If the cookie corresponds to a descriptor that has been completed
> +	 * there is no residue. The same check has already been performed by the
> +	 * caller but without holding the channel lock, so the descriptor could
> +	 * now be complete.
> +	 */
> +	status = dma_cookie_status(&channel->vc.chan, cookie, NULL);
> +	if (status == DMA_COMPLETE)
> +		return 0;
> +
> +	/*
> +	 * If the cookie doesn't correspond to the currently processing virtual
> +	 * descriptor then the descriptor hasn't been processed yet, and the
> +	 * residue is equal to the full descriptor size. Also, a client driver
> +	 * is possible to call this function before rz_dmac_irq_handler_thread()
> +	 * runs. In this case, the running descriptor will be the next
> +	 * descriptor, and will appear in the done list. So, if the argument
> +	 * cookie matches the done list's cookie, we can assume the residue is
> +	 * zero.
> +	 */
> +	if (cookie != current_desc->vd.tx.cookie) {
> +		list_for_each_entry(desc, &channel->ld_free, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return 0;
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_queue, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return desc->len;
> +		}
> +
> +		list_for_each_entry(desc, &channel->ld_active, node) {
> +			if (cookie == desc->vd.tx.cookie)
> +				return desc->len;
> +		}
> +
> +		/*
> +		 * No descriptor found for the cookie, there's thus no residue.
> +		 * This shouldn't happen if the calling driver passes a correct
> +		 * cookie value.
> +		 */
> +		WARN(1, "No descriptor for cookie!");
> +		return 0;
> +	}
> +
> +	/*
> +	 * We need to read two registers. Make sure the hardware does not move
> +	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
> +	 * should be enough: initial read, retry, retry for the paranoid.
> +	 */
> +	for (i = 0; i < 3; i++) {
> +		crla = rz_dmac_ch_readl(channel, CRLA, 1);
> +		crtb = rz_dmac_ch_readl(channel, CRTB, 1);
> +		/* Still the same? */
> +		if (crla == rz_dmac_ch_readl(channel, CRLA, 1))
> +			break;
> +	}
> +
> +	WARN_ONCE(i >= 3, "residue might not be continuous!");
> +
> +	/*
> +	 * Calculate number of bytes transferred in processing virtual descriptor.
> +	 * One virtual descriptor can have many lmdesc.
> +	 */
> +	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
> +}
> +
> +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	enum dma_status status;
> +	u32 residue;
> +
> +	status = dma_cookie_status(chan, cookie, txstate);
> +	if (status == DMA_COMPLETE || !txstate)
> +		return status;
> +
> +	scoped_guard(spinlock_irqsave, &channel->vc.lock)
> +		residue = rz_dmac_chan_get_residue(channel, cookie);
> +
> +	/* if there's no residue, the cookie is complete */
> +	if (!residue)
> +		return DMA_COMPLETE;
> +
> +	dma_set_residue(txstate, residue);
> +
> +	return status;
> +}
> +
>  /*
>   * -----------------------------------------------------------------------------
>   * IRQ handling
> @@ -997,6 +1138,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>  	engine = &dmac->engine;
>  	dma_cap_set(DMA_SLAVE, engine->cap_mask);
>  	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
> +	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>  	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
>  	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
>
> @@ -1004,7 +1146,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
>
>  	engine->device_alloc_chan_resources = rz_dmac_alloc_chan_resources;
>  	engine->device_free_chan_resources = rz_dmac_free_chan_resources;
> -	engine->device_tx_status = dma_cookie_status;
> +	engine->device_tx_status = rz_dmac_tx_status;
>  	engine->device_prep_slave_sg = rz_dmac_prep_slave_sg;
>  	engine->device_prep_dma_memcpy = rz_dmac_prep_dma_memcpy;
>  	engine->device_config = rz_dmac_config;
> --
> 2.43.0
>


Return-Path: <dmaengine+bounces-9095-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEoWKkkpn2kOZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9095-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:54:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9219B04C
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A124300F114
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A529392C26;
	Wed, 25 Feb 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVNoQXzZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222426CE39
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038471; cv=fail; b=TvkWEwxEpe9yuNw/VTxlqo1rv25G0r6SOjeIloGOinky6xE/gs7X+IORFy1/3hy6Yfx3O6grVsfgNU4BEy80UiYeI3/LbGe4Zt5R6HILIvhOvg2WObT9xLWF9JlYpoh+jhARtMeNQ5s+9VupAQ3n44KsElWkDnxv/TrFaIh9pVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038471; c=relaxed/simple;
	bh=dPLhtTPWd9H6imTZU9cWELYNfTZX/jNezrpaRGRzB/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TUItowN8vexvq4DwXvzaAb1m99foL4doCY0mNjFMwqT7dQ99dm0SZkSb3FdO+me3ml07Lpsdzsm+3ZWnZ5x39w5LlpIspANu0NLx7B7wJ2DZhBVU4f5ycFo3uPfzabvHQYXHDQ5DSLymcPFcKO3cf8UWzybkfngoGugJ29xv0DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AVNoQXzZ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bI77PuF3ZpdrA+6WQDZTKcZV/UnWhPZ1MWCKUkvPcyNKyj3BYteDrI7IWq+khFaHpfSSOThKC7qo3wEJnC8y86ItyubCfgxt5RF9kTMj5/H+qqVx3WA/B0BY3rctuFaP46lkxLY3ZJ/vkqRrHEn6WwMyEj7ytAAtqPxWyTTI+kohGTL9yhFUCzLa+ziMbUZaKp6G7IWncM7LScNfZOf4452S1ybtr7xM/oYhcSv39w5Ssu/zlHjEIJXTOuR9EkCDkmDBxpqgHwerk/G5dYajNV3X2MY05ll+dbn+80faolHKEZ+cVX/myUyE5hOuQFs2uwRI2HGfiaqgtQ/gxS/CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCmfvdky9uFxfnAn8QDgNi54+ty77v+gZDotTfYUCwQ=;
 b=F3ML6TTuJN326XaaM5PvKU4g+n335YMV1Gh1bgyiXUDb+DS0WGVeyNoYSNwzfv/+LUAPOjoxVHm1yRyscj9QyIWjUWGDoPM3e9Qacp3l6CWsRVTKRvHGOYBLKUoB8PQyx0/5qYbpP7XgLmOyUEvQUzSWHpwuPucgxqoFOp+R5G6s/x8jtnqVhAtU6kycMCyaOvDlG+f0miMjp5dOnVha4k9i7bDPEVFhcnjm4q1Jg5HHKmRlBfJd3f4ATNWuYAQmlUkEx8UxE4UY4/+F1kzHUzU6K1MEORZAcJy5PHNnAwJFSAhbYf+jNs6g3gOGP4VFMNk4+hPqERl+jTuG3Kfj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCmfvdky9uFxfnAn8QDgNi54+ty77v+gZDotTfYUCwQ=;
 b=AVNoQXzZN5+TO6hGvV0tG/oQ5W0tP9w+SBRbu5EuY07vt2qeBKJb1r+G5dcyb+UVk4sIRhHzg4tzMHV1t/XveE3VpmH5BI/eRf8Ty5jUnKjbLDp65jUQTDgf2LpjtipOHpAAUViM1H/ESYyrXiuClyvJSuDn699isS5ov84IFH0yVOy4fEQ3CY2UAIwL+BrMcMkM20PqU7Y8Q/3ApJ3pKblcc3vq5ZO8niGHomQoe7QD9hiGwNbIghWsP5NvrKuX05Wruluol1BqfdlWisUcFKWuBfuDRwRok0zSHYri6zqqML+c5kiklAsNVERCAbJzUk8n04GMrudJqBrAopaoog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12303.eurprd04.prod.outlook.com (2603:10a6:800:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:54:27 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:54:27 +0000
Date: Wed, 25 Feb 2026 11:54:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 3/5] dma: dma-axi-dmac: add helper for getting next desc
Message-ID: <aZ8pPDsJKC0YeSlx@lizhi-Precision-Tower-5810>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
 <20260127-axi-dac-cyclic-support-v1-3-b32daca4b3c7@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-3-b32daca4b3c7@analog.com>
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12303:EE_
X-MS-Office365-Filtering-Correlation-Id: b9778095-e4ff-4401-c284-08de748e8962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	mJ0tQtCx8G3vWgMQKGfscRx0wcjUm28oBYNChUOLVb2d2ocOEY+dEEVohTZr3DfyjeQQclGPV+0ukrVnC9WGKGPEwoGac215CIOmTXF4jMP7sO6c6HYyO3XsScZYJ9TiiaH4SHgm8GV2TzvX5WWN8INuqxUcel8YJTYN6DY3rOv9kmhf21yb0+Vs1jxytWE6BK4GvWyF0F9+thz9yyvEBX+X4/4WpZWVLQvZ5bmnP9DpCFqZhufYa4sj327LtM6JIl8cM3TIRTHxgoUmwDnQ2pCIXWCL6337u37+UrAgrQ+7uFHV4epfuM62bDhvOMmG/KlvukpB0T5Wa2yULKQEVukOr2pMZEEBSoyvg0nGwZCrXyncFUTLP+6Ft4yPcGLgyLzcy1jIjORjlv445onNnKDG+87O1aVfsNFJgME54CfmzH+jorVms2i5X+0fjd3REkvG/mEn3Lwh2N6S0bMZn1dI5i5X9MkWPpW39nsL9OXkU3o0cRlXSvdZEOAmQEYmzkVDSuZAAXoAM+DNxNISZph8mYhXvBsFOtLr8H/urrWU4YzTZ8DnG6TS07F0M8GVsM4dB2mheWyIvAYiG80biN4x5By/LNzjU/owX4g78r/2MYGIIh9Zv9b++UToL8j+cKjmMAOKvrPDfCIowV/dRTIwxY03oFL0nYXe3p0vtf1ob9RKDJQN0o6XvhBwubHfJRcMefCr05mR65If03pIBt0OQJDCpmiFUnU7g5XCOAfh78pL0xqo/6U2YDwjaxU20ZWRbTHBNidNm40JlmKcNRuuKisNUCKM3AuBBFRSozs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?17UPB6zbszB7J75haWQ6jm/163sRKH7F1mNVTHiobD7BB1GtGYx27f4rim?=
 =?iso-8859-1?Q?Yh8V7y378rYA1yz5weQ+oLOlqEBGTVEHJpMB9IpCVO5Ga1ckjUKDWqD2LN?=
 =?iso-8859-1?Q?retV8CNrOl0OSXnlIUFrswr9SKwdj0zr0LEVAVGTN2fnffWH9dCf2KmDUs?=
 =?iso-8859-1?Q?LfdgEUdAb8XOGhjNPBN820OOmY7ccTMANq0eS2aO5orLMrMG5B2YabiUmP?=
 =?iso-8859-1?Q?+MVGC0Y5Z5zm3OEd+y2feliVGIgCCbs0K1HjJKyJsN3jyHAcYQ7WykCM7U?=
 =?iso-8859-1?Q?59O7zMb7Z6XIvDVZzpwV1CRWqksTpiNPGxL6CnNBXT5jhD52qHFi7NfJOv?=
 =?iso-8859-1?Q?01iAzzK34HQKHky/SxGouJ4l3A5EX+IJKdcgSKLod0oU5Be1uf6UL7oG9S?=
 =?iso-8859-1?Q?pyuP6ZVnU9HXcRyq3VoFBhDHv7kDRgW6GBewJagPESa6J+AEThfvZ4EuPz?=
 =?iso-8859-1?Q?+97htB1INgnHEc7Y6M2AfhGWbzCnVXi29zMFMdlow0BBHkZ7gGabmoJV7a?=
 =?iso-8859-1?Q?BiuI8uG8FsKThDiQ+SnbHYE/4yyVbLKvXPF95jN5nTLznIkWnwuAJoTl95?=
 =?iso-8859-1?Q?rAoJTpEcRr55QI9iKhwoS9Kz08WLKUBinOAX4hTz1XMRx6edwhR2kPFBad?=
 =?iso-8859-1?Q?amDSQO5k15UGGH3Rv+YfYE9J03ml8UCCOuLtjuGRB+p7SUFVp7XiTgPWFi?=
 =?iso-8859-1?Q?6LUoPTw0NNk6CrluJvEbuUzWgQB4iSpP5IoF+JflvZIGKQyG3RgRKqZtvL?=
 =?iso-8859-1?Q?RhoSOYq321DyZGtvmHZlaOZJqd08zmt5SxG98NcZbGF9ZRrgWRaQPfhoDi?=
 =?iso-8859-1?Q?SmaUOh/XHyYSNbnsexBO+a9MJ8giYTGN6i1+mxHEJe5TAHB3AaDxwWw7bt?=
 =?iso-8859-1?Q?JljXIVpO3y2wClYy+trZmSaFMxI1V72qGgPXq2+Ba2DAyo7orHg8Ej0VwM?=
 =?iso-8859-1?Q?hxKu8cPVmU41vKK/lMagUk3lRhs8AVAvkf5CAZBAfK+bCsFQd+OaqtWdK1?=
 =?iso-8859-1?Q?A80yaL0ZjnZ7pIzkhe7K9XsgYALxPO6K/bbX9U7LG3L+QAxdUqZXS6o1do?=
 =?iso-8859-1?Q?Kc9Twv2zo05o93fJARojB1fpGw7R/SP4mp/SaTSkfj1xxVgZSMWHTjhSp+?=
 =?iso-8859-1?Q?trttCeKX+SYFS3ANGi0jVqGiw2+gsdcDAnMT2ohhzrQYfrepOzG7fIHS2x?=
 =?iso-8859-1?Q?ll1pCoTnYtZ0V6HfV0NXyDovs/E/HlFFm4MfjhPawPTdfoU8TcK142fOwv?=
 =?iso-8859-1?Q?myQKFIJCTXl3oZmjs11J976C60NSqavSpDCoRwQee+ZiqSBEhlkyF+8HTp?=
 =?iso-8859-1?Q?WH38HxzFsevyTop+1KnEOt5dqZiE4NGRUz80+HQTb2tMyWem5OZLaramvj?=
 =?iso-8859-1?Q?Zouav3wV/1j7kr4FZTT/cGk52HGRdsy6Vk+AqPMq8frM7SLaBGISNdPze4?=
 =?iso-8859-1?Q?/vmgjxwF82wiQXZnEznL2G9Qsz/JcuJG6aIGmfBwVaZ23wkLW0jjBpNo+2?=
 =?iso-8859-1?Q?y5RQ64AuSTEtePXnGWSY8eZrSLX3egdSCC8rmX2AYLQP2wUm/gYVpx4exl?=
 =?iso-8859-1?Q?kghbd6UTFCVU5VKpo0XWw7tqmM0taQR6SloW8bC7o6rOPAqQb3xuXWDtwA?=
 =?iso-8859-1?Q?I9Rv4f/TKqOiYxzYn5kTHj7u5P9Sf7W65zUKXKC5ktmKAWgxhfi4n/Y8P4?=
 =?iso-8859-1?Q?vIDAefULl6hU7JZFmanSR/N6aCU/CTC5enuN8yDGGb+psL3XejBdXPUCAW?=
 =?iso-8859-1?Q?Fs7KXnTPaVJdluVqaeFDdlWPQJLT4WFZABi6v6g/I5YBOO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9778095-e4ff-4401-c284-08de748e8962
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:54:27.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cpac3def2Q9TLdcvipm0SsCFe6oqXML9Nx3h64Lm6E5zw04qFlks4iWDT1VscmuMRQ3g8MoCgL8bsZFWBJ+49Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12303
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9095-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,analog.com:email]
X-Rspamd-Queue-Id: 4BB9219B04C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:28:24PM +0000, Nuno Sá wrote:
> Add a new helper for getting the next valid struct axi_dmac_desc. This
> will be extended in follow up patches to support to gracefully terminate
> cyclic transfers.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index b083b6176593..3984236717a6 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -227,10 +227,29 @@ static bool axi_dmac_check_addr(struct axi_dmac_chan *chan, dma_addr_t addr)
>  	return true;
>  }
>
> +static struct axi_dmac_desc *axi_dmac_get_next_desc(struct axi_dmac *dmac,
> +						    struct axi_dmac_chan *chan)

Nit: if need respin,

static struct axi_dmac_desc *
axi_dmac_get_next_desc(struct axi_dmac *dmac, struct axi_dmac_chan *chan)

This is also fine.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> +{
> +	struct virt_dma_desc *vdesc;
> +	struct axi_dmac_desc *desc;
> +
> +	if (chan->next_desc)
> +		return chan->next_desc;
> +
> +	vdesc = vchan_next_desc(&chan->vchan);
> +	if (!vdesc)
> +		return NULL;
> +
> +	list_move_tail(&vdesc->node, &chan->active_descs);
> +	desc = to_axi_dmac_desc(vdesc);
> +	chan->next_desc = desc;
> +
> +	return desc;
> +}
> +
>  static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
>  {
>  	struct axi_dmac *dmac = chan_to_axi_dmac(chan);
> -	struct virt_dma_desc *vdesc;
>  	struct axi_dmac_desc *desc;
>  	struct axi_dmac_sg *sg;
>  	unsigned int flags = 0;
> @@ -240,16 +259,10 @@ static void axi_dmac_start_transfer(struct axi_dmac_chan *chan)
>  	if (val) /* Queue is full, wait for the next SOT IRQ */
>  		return;
>
> -	desc = chan->next_desc;
> +	desc = axi_dmac_get_next_desc(dmac, chan);
> +	if (!desc)
> +		return;
>
> -	if (!desc) {
> -		vdesc = vchan_next_desc(&chan->vchan);
> -		if (!vdesc)
> -			return;
> -		list_move_tail(&vdesc->node, &chan->active_descs);
> -		desc = to_axi_dmac_desc(vdesc);
> -		chan->next_desc = desc;
> -	}
>  	sg = &desc->sg[desc->num_submitted];
>
>  	/* Already queued in cyclic mode. Wait for it to finish */
>
> --
> 2.52.0
>


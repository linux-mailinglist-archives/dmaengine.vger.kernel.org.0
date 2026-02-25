Return-Path: <dmaengine+bounces-9093-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dw/A3Mon2nmZAQAu9opvQ
	(envelope-from <dmaengine+bounces-9093-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:50:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2B19AF99
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CCBD3001FBB
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE63D349B;
	Wed, 25 Feb 2026 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYBWvo/c"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6238E112
	for <dmaengine@vger.kernel.org>; Wed, 25 Feb 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038252; cv=fail; b=dAkB/pPH3awQhOqxun7q8I3XFNIQ07KtyQTFKfhgOg55lfnrIodSGEto2/NIYdWT97Fl9Osau+KgfXZ0SHPj19wnk5/oOKRUAlqEubLW3Oavm++to27S3YXJXUzoupb0wf/FEBY8n5yHrAc0CS1uyeMXLT5uDrBN8dRKoDiAgyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038252; c=relaxed/simple;
	bh=cRXMLZ7tehzv9IDERci6VL8b7ZH1aQmbdTJO+fJrujU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f3NgkFvHndOaTBKeMzd+LJ6VyVSQ6cVggZLYBwKgEqjputW038lz1U5RNv7YtoDqoOtYLfwYBogVFJbiFKSaRmSPttKy8M0SPSOxaF3h/qob5lESDB/T8ARce4YiEJOnWRx/123UwRN2Wt89eCea2i9M55DJPyOeRqJJnTbpIno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYBWvo/c reason="signature verification failed"; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENXrUywNEew6wiG/UR567LablEA13N80MOjSbhQRuodZT59IyEgJDxFscgG54hMKMUFW1u2ZnUyp2swvVmjYN8ej/bg45GoHTa/NLAreQE9QbrsqAx+hGAxzTXhfnGOa1HgUxxOUt5y7yIsEHkBqiqgy+74dLYIw0VzIcgw3Ksj7NtMjwUqwro12JLJYkMy3VvNj7GGALcGp4iOKHxL6bFe6dYNtP25MlmPCJufPdM7HcGdWBg4BPV+xhYuPBjqUxFFXmYVciAAwtEjj7kUbCCuklK6bQSt7q16kueT3njBkUzPTk+C8NQyGBhiNdC4PLhl3U6GBOE0LQCXgw/V8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03nf3rsgO7PuR9csTq8BqGpsyZ6gGYAcMgljBTuRpMg=;
 b=NyQmzaAKyCmoT/dA9eojdQaorUm2O2GmvCjX0HP3NRVvpVczKpKfG8f2HPPfGyJ2XLFEaHooZ147u5yMciGbyhSWbW/vxGEZ1BolrBb/PZCxxIV8MbLWi/uIeWx9fOj3IMds8ZOVKqZL6W4jiI5QbW7SddCQbXbn3xpFTPydvyitSmzRNyXIiBA+xikzplb67/dF0giIe+CcCW7kEb0++s4exAGSUd3bSl/tuQuuyGmErAbBmcnTE0Z1GWLjvZiVTzJEcH5PoloXNm4ViPni8wO1zn7QIDzagiy4qGcgC9u7T+xvTr+uLvvAtms247wI2dk4Mso5a5XFNkq7E7B29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03nf3rsgO7PuR9csTq8BqGpsyZ6gGYAcMgljBTuRpMg=;
 b=hYBWvo/cvjbsU6CNGL6gqsZ4EvA0lHWeFeOq26xYyH0eG181p0kqZ4dakQI7gB2dCfsaX/Kj/sDtoBDDZe3io1x891v3jdfjxWtKHsWCAIreRetZ3sO7xw4fuWFVZnqxWJHzS3pLllo+5ntP6GesPuWknpFI1RqsLYo1hLj9dnCtsuP9OU1zyJt6fLU0fWx2J8VcdVPMHJ2n8TNHjcFwwglVXfsXhOQb4d1zROCBDtkAeabANPz9+VTQxorp4G0Kh37kxBnUpSwhZZ5Uj69tPifv4FMM9aIBoVSD4KB+UbU1ZxEvTD8GWbmQqu1Y5vUB1JdlN6UuN62G5W2zLCTekQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12303.eurprd04.prod.outlook.com (2603:10a6:800:326::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:50:47 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:50:47 +0000
Date: Wed, 25 Feb 2026 11:50:40 -0500
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/5] dmaengine: Document cyclic transfer for
 dmaengine_prep_peripheral_dma_vec()
Message-ID: <aZ8oYHNT7EsPbj5D@lizhi-Precision-Tower-5810>
References: <20260127-axi-dac-cyclic-support-v1-0-b32daca4b3c7@analog.com>
 <20260127-axi-dac-cyclic-support-v1-1-b32daca4b3c7@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127-axi-dac-cyclic-support-v1-1-b32daca4b3c7@analog.com>
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12303:EE_
X-MS-Office365-Filtering-Correlation-Id: a957bc8d-bb0f-4c5e-8e18-08de748e065f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	1O/k2Y5Ko0LyBiTz839bHw742xLWaiKaA9MTIW2aSQMPbwM3mX9LoWBvlgbXN5veG48S3ae+ZrzhtBvaFOgJOMcmsg2wIOVbHkkI9l0amSaRBljatVVcCicUbggdlT6O+Hn1yYPCkXGVeZNo1WviYRqCWXeuIhguGPWXxdhodCt0+OslzFI2nJN4MjOt4LjyIFUMb/HCmV8S4LS1Mcpe4jLbFqAd5XqUdi5JnITa9xp9FRw65HrTc3V1uMh2P8zXVnX3lrsvijbXOsJVQO6nYTlFJXICSDtkUpFhilrOb0+s7rSzuiStiYZW0lpLCRlu65DZpwWeHxTnT/wbR2j3ERYz+WHykDjDCLdWBPSsfe06gU2sbcqxCEcANFf3xbEXGCzA8/dauA4zSJpJqf9UKzWOdAmmeLSDTRDKs00u7M82QCMhkOIf09O6arfuv6e8NrVaPDHE4LE7llEp70SR0hlkpuKnrhW5ALHW9k6h4AuWvxcjG8HFNPQdJBcSdMBwoOfd5dmE5lXMXB3atFLLp2+T7W4H+gR9Sl/rfCiwvGJtROv9wc5sg5zCRnVoo7kkaagCwoG5kq1kWr1kZ15KxtNSj5cOZ0O5c9tF44XgwJ3TOhKDZi0mNCZFfIKokQgiL9SMjUlEsOmEmSPxXlg6TsDeS3JOprJe6zkTPxTfbpZRLJO5Y6kNZg0fMF/pX32qy006N4xA8CNv151aYoVx2zM+bbUifeAgZxPsmNbnMU13qcDmejZqdVxXO7Q07VI5XUylCeVXC0MlxOfV74dLEBHR4kkutlZsFCymGA9hDzY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PdXxmpWNOQmC7KecbzSmzr0r51uSYFwfkVNEiXqlPyEuGYYyPyPu5Y5Mtf?=
 =?iso-8859-1?Q?CtUkQWAa91EK4NUGb3Hz9X5+LTBTgVCbMW/05Kep7+b1BBY+y7cAFfm/1n?=
 =?iso-8859-1?Q?dnqAZli3KK5oJOtLpxGHd1l04zxJDtkZGO0P24l8p437y0M/ZmmkncKmFg?=
 =?iso-8859-1?Q?qAlVQaaZaJVVarzQhaxYOb3AwT8bIfRK840c1ZnXfjL42AuCNzqH0qQF+F?=
 =?iso-8859-1?Q?kXLHs/Wfsff5y0hG6oJecT5Kyz/iJTu12yhrPshO//u+MuX0ZeV4El5OFp?=
 =?iso-8859-1?Q?gSKj+Naukaobem8BX/JQdNKgxa8AR3X0uXedTubIRY+SdRhAwscI9HY3LY?=
 =?iso-8859-1?Q?0ohQRBmcMa4SQqnUX3QyW/x6teC92h+PiyZybIu+gQyBtmRM2Zz7ySUE8S?=
 =?iso-8859-1?Q?ANp3WXSlFfZLo2zzln90hLeI0UTgSx5ix5kJ1VvPhf0j0DplY5XxGVhs/E?=
 =?iso-8859-1?Q?EpfGqnScgefUa5MOyvi2WTYqVC+yETMEZLnllNLYyX9gh7B/P+JegZ616I?=
 =?iso-8859-1?Q?w+xqMwPy13FU4DSqXVij7aIDW/FHLytQuyqRFlXT0XEaWhz2QR/JSbPqKu?=
 =?iso-8859-1?Q?91vo/j7G9Fo3ROopuFjseY+MFI+Yv5QoJ8hkwljsGy9CLjiXDjYLMuAAo8?=
 =?iso-8859-1?Q?DA0rmn1rAiurop3IVXLdpowC7yLb/EnVC41jYMCNTRJlSEc48qKK0NY6go?=
 =?iso-8859-1?Q?/UcJKbiVe/ysm4bY3vvzHpkkRYXDHoX7X4wDESRs68dF/tWHJ24A09rfz+?=
 =?iso-8859-1?Q?VcDt+tCLKImrcyu2qiO6i9/wZh0ZYE712D3Fo5m6oFMux4Zr64aLGbm8KM?=
 =?iso-8859-1?Q?mmZNceqZHfpOGTyPHcIMWR64EDxkxCEFx0ovTpt0jFYo8rHIgL0z4RSEeD?=
 =?iso-8859-1?Q?4LWyuRJ3yDcgPg1EZ4qq7aKIF4Pmy+TC/gC3QlS3D4wIeHx/53qNad4oxn?=
 =?iso-8859-1?Q?VOc9bQXph2rOGQBKszA2d1aEGSWUuxyrZO9yNjA+cOm3utI17HWxct1xZl?=
 =?iso-8859-1?Q?9TPsWvPOG+1vdbOeU4bfHPd/PjsyxurTlWcY3ErWEIU/O3r1+WXf+sVrJW?=
 =?iso-8859-1?Q?sjOdVuTwOLhlZCDvauRe30LBpuB6Ug3AvXRn26u9B3sL2JxAB4xn1t3L2a?=
 =?iso-8859-1?Q?d4KqzIcYtCdLf99XdAwKKwWmijVkCWIFcRSA7LQnSwzuqgDTxJ+2SpCJKe?=
 =?iso-8859-1?Q?oiJbdbRxWQG2QUrFVvyDwOJvewoBNnsB7pWQkhMfQDMYq+hFRpY4LLcKr2?=
 =?iso-8859-1?Q?ixEviXC+i7wBTtOi/oFqyEo1iPK4n1U6QGbDaNzh50XTQE/uOR9PbC8urL?=
 =?iso-8859-1?Q?CU65M+yPdcVmo6Jjmn1cKc+s57lVgw1pkuiHL97ER5PuJBUQz7H0R4rndA?=
 =?iso-8859-1?Q?qg5veXP0Sl1qnnGR5pcDgqEJ3c4IduYHup6TyRzr4U4y4+1+5bTnzLvl5E?=
 =?iso-8859-1?Q?EWwrgXRJhfdxjtdHNDkWIalaw8M+rhsxXrqcuYwaoZ8sa8AGvg6AsKBHBn?=
 =?iso-8859-1?Q?TVKpgV3B8tipDV+kU8WYz9nIjuU+QO3+JX6CiFN8d7QDQEpJPSz3LvP96p?=
 =?iso-8859-1?Q?PiGnX2Go0HJrhs4FbT9/b+kvAorqLysXtKIab7G4liR4fndku5+24WkMng?=
 =?iso-8859-1?Q?RDuIaXMzn1/a529wOTnDY5D3Qv6Syet9Jrmu8XHy3tIrVVG/57699hoUom?=
 =?iso-8859-1?Q?qMrTRkfwbOS6SMAM/XXwWQMvjaMpacliBvywFqJ1pbXgRC45gqGWLppkXf?=
 =?iso-8859-1?Q?JJSN0rSkI+3g/SPg/pLUhu0gkwONAcqAoRQeVuDnJceLyv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a957bc8d-bb0f-4c5e-8e18-08de748e065f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:50:47.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Su7kJSbYAH5KpsVHSzksPJaYul5KyIDFkAxGywVWKy2BB3AA0MLL1Uw4JbZ/VYdguFCAEEZjEEGzBeghS3bDKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12303
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9093-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20C2B19AF99
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 02:28:22PM +0000, Nuno Sá wrote:
> Document that the DMA_PREP_REPEAT flag can be used with the
> dmaengine_prep_peripheral_dma_vec() to mark a transfer as cyclic similar
> to dmaengine_prep_dma_cyclic().
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  include/linux/dmaengine.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea..b3d251c9734e 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -996,7 +996,8 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
>   * @vecs: The array of DMA vectors that should be transferred
>   * @nents: The number of DMA vectors in the array
>   * @dir: Specifies the direction of the data transfer
> - * @flags: DMA engine flags
> + * @flags: DMA engine flags - DMA_PREP_REPEAT can be used to mark a cyclic
> + *         DMA transfer
>   */
>  static inline struct dma_async_tx_descriptor *dmaengine_prep_peripheral_dma_vec(
>  	struct dma_chan *chan, const struct dma_vec *vecs, size_t nents,
>
> --
> 2.52.0
>


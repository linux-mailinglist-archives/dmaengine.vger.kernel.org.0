Return-Path: <dmaengine+bounces-1828-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED878A2429
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 05:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25411F22155
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 03:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26013FF5;
	Fri, 12 Apr 2024 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVtvvc+5"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EEF111A2;
	Fri, 12 Apr 2024 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891224; cv=fail; b=T71S1T8kGereTAjj1tc4NDSBu9AGjFKcLrZs/nXyl8Z4j/HnLPnz3y3wcr3I8EnPafJHsvo23kMGuFRQwWuoboeHGEAFDylTqXbCauvdyTcMDNRP828josl11dRenI0WFT0uicZTPcXmoRmjXW4RFaYJCbF77vGi2HiGCbQ+2HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891224; c=relaxed/simple;
	bh=/HGGWt4fWPNopjXcJgr83Q70C1PFO3+nlWOMy/hdXeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qlzexHAeKLXYwT1M1L857ZUY7MPybXb/lqD7FHCGGGB7XrT4MB4XKNEoacEvrkaMwaVubhRgbU9LObVY9bwJfdx7/1XwjMkOWSzLXfhS5UCL0eKH9ObNkmE0p4V4w5R5BYrbGzUwccZdZFt2s2m2CVq/bL5ytWLR+Izn61iePHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVtvvc+5; arc=fail smtp.client-ip=40.107.104.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXQTUqJdtVvQzas0a6OysdAukkkIgqadT22e+1ynUo22pE3r8uvUaSTyPQmG3u8mFOdgEKpOh9r1aOZPtqE5MFNa5zy+Cawb3KASMzrA0YDpMfJ+YFXrd747wPZccOur2nG5nX4okZQkxla1bgADdOvxEPjdzDbpwqGL8tmsHf+HJz4CxP2Mbc4Lw0TpiSePjrJFGPDq9is623VdCs1HDmdj+2XsLKcyGq+19AaolAzYKw4zqgHvttQLOTS8ukx+unSsI+ZNqQ6/kOH9iVa4LanL92g+WABC0vyBRPM7ZzR9PoPOvcvR5uHHn4MeSdi0Wtfj5gy3erQcGuYF8JOqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aPIM7AC05nsOh8VADgJ9+bJjCgGroy7Z0cy1lwHNHQ=;
 b=OH59o8sHFbvTq5BX8YvAR6Y0iSDqziTboqsEtcwpFdBM28/I97bZ3hfuOLGyoykBGwbFCGFgIRrmNSFUvMy5mgPhrSQkxZzEGipFZIlY0eKoUK6U2OrWOpG0F5F7/TcYLSPKH2S6W26Dh/AK8e87AVQ/4Bh1fVcgUcdA1nSOi+0yFXgsw1EZgru3jIhBIyodNZ9mp+GE1Xko8aYGpa3iLk+N/ltkP4+jfBS5pUmu4pCmbl/4q/wRVPppn9BDhr0PVhISlO8abbEjHre7CcU/ZYIYl150Fykvjkz/MraILXwmNMGjdSos8qNYHDcQMHpu5c81FPc383VAPtCf4F0QDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aPIM7AC05nsOh8VADgJ9+bJjCgGroy7Z0cy1lwHNHQ=;
 b=RVtvvc+5YglLtXFlk+meJTfLS+OB08Gk1LUDAJ96TzXyXqSYkDFFgcZckDahmNBWCPNrF6mDGoKiVkwU/qWy6tvF4iVLhw1QXJhwfzJZ4LXlVTYe8ra+qkVHNWSZTYd/gHiEG2/vOC+MakraSwMgIFOIqL/eFa1zPCjQ9eOd+dY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 03:06:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 03:06:58 +0000
Date: Thu, 11 Apr 2024 23:06:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: peng.fan@nxp.com, vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dma: dt-bindings: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Message-ID: <ZhilSv5xh0hJ2vdX@lizhi-Precision-Tower-5810>
References: <20240412030436.2976233-1-joy.zou@nxp.com>
 <20240412030436.2976233-3-joy.zou@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412030436.2976233-3-joy.zou@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f16df9-367b-45ca-c43a-08dc5a9d9dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	phdsBeMEQ4CiJjecA4fZCQF58wNn9OqtJELsbo+Y/WqEPdvl4/DKjT2a11iq/88OGyO62McVsEYwgVGlxjZDHl5OvvxFIo6NfWjDF3YueRgDWTp7Px+7b/7JCbjQCoT9P9UvZS1zy8gwgXQZH3rFsCxmHw1WlTgZRRaZTHgV6lMrrqBhFeK8J9VJVKtxMsr+rUz/3srVgKbNrsvf+h528p8EtWucDKiSZy8n1YlIz8eNQQWPAyM0scEwzGtRSN6rrZH0JkrTsOXq8Lq8z+EbElV6zdaZ7k2bDBRwjmdBAcUOAWAyk0pl1Zw0HbCpTM4Wcvn8JEeY6tn5Dn8y1CTF+HzkIGS8iwSZw8ZDIQQQtRfKe/KETXwfhpuAs8jRtlqefVERPUZKs3iTw70QNVzXgo+psvyNoWRfRPoHAGAz3vNPfxCPTSvheGamedbc0RyrdQmTqQLKx5os/n0wLBhyQB9PyqF/NoAGEyZ42Ft4gxmakAwJ2vYlSBnnuHoGPwvZG0n0FJgJ0g9OYVCNU33fUaGZd2e3EY+Iyu7rI2X1C30T6DaVpg0CRdYcsJgXkcecWxk7PTRG0zmF9sNqtO8YNOJKfx2m+ExUKZwBSWxrxUEAvHcMJ6UG35+WVjVUJshmEIyBQQO592iCsVBRSOgM8ZnrUvEPN/GWkgFfoZ+tkHHp4O0rwklEtsw6zpQswpc5IgczE2iF8G9Nvu3EukBehA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGtMzMdbQIHy3G3GrWDO9vyjNF03A3XPmT9j1uI6Ft3Lz6P/YfMYgI9nqiQY?=
 =?us-ascii?Q?LK/EDB0vjwWoef99lFqr81n2i6Udxpo45HAuJXVHl2BUh2mki1OCMr+sk0HQ?=
 =?us-ascii?Q?8Nc0OYqDN8WkhSuxV1pdGcwRI41OVv0BmsCbv9gbfJrXC8/K8JXvhhTtiiZ4?=
 =?us-ascii?Q?HGVDmqfFXX0LJKwKaIzbFPQKjWjew9CFD629IaRrREUeqL3XvqksRQb5vO9W?=
 =?us-ascii?Q?dpHPKqyHqcuIsnZHoh2XzX8AYxl+isdLpjPfyOc4AOWdAx0tGSC6bWssxoG4?=
 =?us-ascii?Q?teVlU6IrxwSK9ksMlwAjnvgbX5b99oi4Gw6HTvpFjMZWOUp2YCs5Uoxh0sp/?=
 =?us-ascii?Q?re7uKc70ogxv1G1xjfetEWZkUQLj7thi6rDKCeOw/qdyutEeEA7jMp6jnTev?=
 =?us-ascii?Q?E8qzqHOXaiuum8qeysgqRgCUwUSrrdBASy5OnL0iklXFxpCeDIlrUq7HJwlI?=
 =?us-ascii?Q?YPaIwMFxLPQdK3ocwgXtiw6DpPhJMPLHdhiOPzmLhuZH+Mgb187pU3GemFa/?=
 =?us-ascii?Q?aHGyR6HTQvvQJOuPZIc0KaLZpPRKN4EBKXwFADjVscOWJ4PoJis/J8aoVzWe?=
 =?us-ascii?Q?lNcfG0YcgFJo5h6CQDwFTQ21ooUHMhJn6A40N+TFIOXEDQZJEt7owxQaGxWU?=
 =?us-ascii?Q?ShWjbio/H4pNjg2KUnQnvU7/XGQYtpnM34vX+hV83bLQbNU/3bruQ6nLX3iM?=
 =?us-ascii?Q?YqRonSx3R42FozpdK+802JrcgHGId152Ee8f+X3h9xhX5dmmmZdBpJxkDJWH?=
 =?us-ascii?Q?Cd6y50NEIK3MWnvjiiGEOnaR4d+rWq/rRLcjoVYdu4V/Y/nh59FF1lJEVMBB?=
 =?us-ascii?Q?8zYcg901nopXV0+pLJhDuiSb6E8spxqwlon+MroK0H/TlJxMywnvux7KWKdb?=
 =?us-ascii?Q?JSnDl6EOgnu7VZ9gArLmb7EZ8j+t775cYrGJXx+kyudqNiFIJtJOFFIdxcAH?=
 =?us-ascii?Q?gIHbjdBRjRgYYbR6M1ba4Qwbjba9NZzAb+p+G34EfjzWlMG1jyOpah2qo5kR?=
 =?us-ascii?Q?BelBCGrLkIBeCRmie4D8Eo+aJYToerDFgv2DeKRXFzUbDCteJy1LoWX/YyRq?=
 =?us-ascii?Q?K3A5/spqGiCDF2h7nGdkqHiLRbxsCyXoTJD6fsEYCen99MMiOSsQvhn06CvR?=
 =?us-ascii?Q?mAPBkklhmPGEihmv1y3DHGp8ql95H7H4GB5Kfe5/GXOup8jPqu83NkGsvvEH?=
 =?us-ascii?Q?QFTmV8uq0/VbRUB37LxwKY1nDYyrWe+4Bnp9JGqgr2WMvRsVEseT+XRO0yXC?=
 =?us-ascii?Q?SrBTpwuJIOLzi0GaLto2NN9cfa5DfD9DoPWwTkVw0xu9/eK7BhJfm/zhmHgb?=
 =?us-ascii?Q?0L8ZXwBXCPD4pa/s105YdTrr0zY2gbI4C2ErMF+luv1m7xGnbYC9S8JX0PVe?=
 =?us-ascii?Q?s6fcBzSz6WmUfFO5WMKN2kWefZuZXJzAk6Tm/j9EzSgyO3WWbMg9k9SMYXj0?=
 =?us-ascii?Q?enRdkOkqmnYz/Zjw2vcYwnl0HvuV5yub3vuY7vlzRIFaWu6u4ZYW8oeKgKli?=
 =?us-ascii?Q?dYARYZQbUcuCcKBFj4V8qVg7IYBuktO8no8KsM0Ey6phFEKY2WJEmc/3rTuK?=
 =?us-ascii?Q?Se+cwnluFzgWlw49BE/H+IcxU3cx9ZwzdqtJs9Vl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f16df9-367b-45ca-c43a-08dc5a9d9dfb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 03:06:58.7834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4WqXLfA2UZH9sOcRsUIoqa8FiZRqnPQBscBrmrbahumPNKnCHE3Pc+1T1WXA32WRwxyrOm5tFoKXTICNscjAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

On Fri, Apr 12, 2024 at 11:04:36AM +0800, Joy Zou wrote:
> The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
> The compatible string "fsl,imx8qm-adma" is unused. So remove the
> workaround safely.


You missed change subject:

dt-bindings: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string

dt-bindings should be first patch, then driver code.

I suggest use the same words, "clean up" or "Remove". keep consistent for
both patches

Frank

> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v3:
> 1. modify the commit message.
> 2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.
> ---
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index 825f4715499e..cf97ea86a7a2 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -21,7 +21,6 @@ properties:
>        - enum:
>            - fsl,vf610-edma
>            - fsl,imx7ulp-edma
> -          - fsl,imx8qm-adma
>            - fsl,imx8qm-edma
>            - fsl,imx8ulp-edma
>            - fsl,imx93-edma3
> @@ -92,7 +91,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - fsl,imx8qm-adma
>                - fsl,imx8qm-edma
>                - fsl,imx93-edma3
>                - fsl,imx93-edma4
> -- 
> 2.37.1
> 


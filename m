Return-Path: <dmaengine+bounces-10694-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFzAC945D2otIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10694-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:59:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8789E5A9C15
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4971F31BCCAC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FB936F8EA;
	Thu, 21 May 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zfbb/qka"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B236A36B;
	Thu, 21 May 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379868; cv=fail; b=rjkWf3FmL0Vh+0/fcxGFNZ1lRgEl8i9ZBqWOVYNkMxyeWpjeWWX2oOUGs614cH2fs/ghHyfu1zgmFfHcPke6UACGkJW4vErhfN0hHfsNC3O3TjdPoHs7JNDFvjy5urkvvRDpWxuIy0HPg55yYhmXpCZH0l9Hr9ClmK9xO/ILaB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379868; c=relaxed/simple;
	bh=b9NU6YuJimjQC3iw/Kf5r4wKTpsNjAMBapyR+TeNpro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdqWaF0zM5IkUfxzxy1NwpsEZ4AQqvH6pWgRnIAdB+V49HSP9y4cLct90yw31iff4hfYhpnN3oef5T6DI76gKQnCoyOgZ8OsP2Sw556bNUWYs9NDgkhCb5H4jFWNNt1yhpfZoJ8zZBcvIMl72WGeJSGtjmUHo+tFMPe2Be5OC68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zfbb/qka; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdTcfko3PwbFRr6OIOs3O+ECHNYYW+CHIf0nqGogveaZceuGBJaDuBFSdZVb7xZCCSdr4mkSk8Hr3FFuV9IvXYL+yBA4zu2HauJXQ0Q2VlK+6/bf2cFvlNNgW5N5nwCIA5h/eYfA4qapM9DJtv/Ju4eGVKQOLTLHnlM5Dc273lFtqRU+v2Oa/cIKrBM7CJyAzzDVF3wbHCv6evtz0O2piAAWRZ8zzbzWGMZdzM1aK+UrRTlPHPH6NTYCSsPlnW8nAcQUs9Jdd8gdGQOuGx5Q4RmyBu36KOAfNu70EuYMFrYdj/qJMWZLkz4xsXoWEJpUJKbksbW+G+56CPbCsiQ40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKCFIrW09Vc6SzMTO2z9wd5FbqqunEpzyn2lKlsRz28=;
 b=hoRjHCDJ6W2F80b9IUTrLzjKLXnzcbo2mGwTjCuRS9XtYA5ZkKW73/VPI0nNmcdKpV37WB1DgL65GrQr/crLNizx8mW5WTGWHG4LSxo2a/WFsY9DT4J6zeDEwyBqTkgn3eINdq3xvdieouBEiOM/LigURkzorFBvm/ejXm1AjvggiJWsfJjkW1iJG3VblQrKt+QxiA2dQA+oYSMdu5aO5HHT3kzPuLYAXzx7g8lp/yO0TJ51SajmHx8//lUTj1IlQ0rVl8TimjfcNGORT+ZPQ+H/xTXsILPoDHbo8fXbHzD0jS0n04F1T5zrx0bsgbR5CbIJ6qXKTlSsPAUJ4ic3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKCFIrW09Vc6SzMTO2z9wd5FbqqunEpzyn2lKlsRz28=;
 b=Zfbb/qka4dY2R3slb5br6KcbZWa7O/f/EBeQHwUbd4lzEyNn6JPTPg1O13yTC8vvDfP91J3V5Yf9wUJ9T6khz52D0voSX+DlFQg29zFvmJjP9KrNP2Ui5ieDmKo+2GWRoeJbkKCAdpSiQS5VXuLEQp9xRfiKXwXmLGwBQaa+i64lFTRaqNPTZIlDk8Xz0ShsW+wTr7l1Ttk2+HYcyoXC4NMoNzVwJmDAEcfa/2JJpjk92cEZZceXJbRrIkmuj0/6VCtZbn2KuvViQE6Uv/pCgigRFRwMdDqEDZXpUhLY0zrEUHxW/AHJ56eLAdGNCOOp02drXCdk0U7MZK9v/olOPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PR3PR04MB7209.eurprd04.prod.outlook.com (2603:10a6:102:92::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 16:11:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:11:04 +0000
Date: Thu, 21 May 2026 12:10:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] dmaengine: dw-edma-pcie: Rename DMA data copy
Message-ID: <ag8ukeDKuw0h408_@lizhi-Precision-Tower-5810>
References: <20260521063115.2842238-1-den@valinux.co.jp>
 <20260521063115.2842238-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521063115.2842238-7-den@valinux.co.jp>
X-ClientProxiedBy: SA9PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:806:28::10) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PR3PR04MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e47f20-bf70-4dcf-b7d9-08deb7538eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014|4143699003|11063799006|6133799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	By5poVj5hCa1Br9UXBWD+Ure+I4/z4PQ9caAlWVSvMzbuWzNnzD1jyijnnaVeQlGcZE2GQ9tdOZGpyar8ty8l00/n3FfksksQ2J1OfgNCePE8n5IzyJe+TB9B++tvelAY36HG4VG11mwvLGAKvmR32irajO+1TvgLQ8D5c5GZFEVhis8ntLy0jcWZY3Dy1Ui9WKRPwFYfmmcYyVV5NI8wigJh0vthB/+c1muaTbBMa2yOYgL3ikgrr8kzXm2c9hiF4EaH68UU8o9A8FqR6BgLEtGnb5P2yuu9MwxGWLdtVrJsu6INdskcZOtJw16hnhyrcHaeCRFwoebJyBcwzQT+ggma74VNsLwsTQNHRrGDPpuEaebH07FNLwfLSefUrln/BCbG/7CjcwVymbQn77ngSSnYMExSm4Xkw9iN2l39MYby7SrTT8vAkDnW/Iu6dh/l7vFrrfykHPUvhraPIwrr1WhFTn9+w9JCOfn6VgrTxQX8QgIbgbWaojNEzTnjX0VJ5mHetNBc1ermR6eaydqJUXXLRmC1iLEitz6aht0yO9eafyOkQgsoPioXAySJZvmxlJ27aEnlivvJA+kYTKjD7E8rC2PzsOHX3fVbR05Kfbz6XTgI+jOhi9C3ESAkZFc5qPMEZmOxU5gmFbYra3l0NBFPIzTVvOeDl42xbBG8PUfkrxHZIgigw4B4hKgusau3tUZizx452nZD37do7L5dqIDcGvhFy74J2N8bvUIasVtAEdOtgJZ91vIhpsHz8H6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014)(4143699003)(11063799006)(6133799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QZxi4W8R1pUp6G/jDqmOC2Uz9harFOrm+WwIilAMruGW1WUzhYChSSj28bIV?=
 =?us-ascii?Q?GXSsKLN9jyqa17i5lSa89njCxwig3+Fjl+Qlgb2DbdaiBvDZw2VbkcZF079H?=
 =?us-ascii?Q?i27Z2EhufGyn7Ah9WrVl3O1IssZxDUlCysF1E5D9gbMs2EHdEBbaWQpvT1NZ?=
 =?us-ascii?Q?YXEu1PrTUeG/IgW+G/OOodQQjU+OptyPVC2Sy1BsJHhFqy2D6pRTl4jeiPYq?=
 =?us-ascii?Q?CdoeDe0BPk+c/ofEZiS1rC45pSFfkIHMwkPJqgVPBVpatCB6TQK9olh6n2Dg?=
 =?us-ascii?Q?htqn+iXFSLlIqhYU08rQir8N0jMnmRCYh86nVYsceh2EdwTUQ32Xo1+qLx1k?=
 =?us-ascii?Q?THH0FrV4rwNRiraDYIhMcg/hFgy1b9Qq2ZJLIt8mUt8LE3Ggd8OhkzW0HD6r?=
 =?us-ascii?Q?jqkennnmNJq+JBw+m2z+WoHgN066VWBFwA1RKTPguU3WfUG139tmgrsUgpuE?=
 =?us-ascii?Q?mLYurhQwlJCt+0R/SFQ5Kt2ebXw/nOCXMmnX7C7/qtVtu2Ksab6T6SRuEKhm?=
 =?us-ascii?Q?/1yG9PKxWQ2vNRK+PzQVCQITI7SswF3EWOAzjS1XmTAq2nUOUsgX9W2iZZcq?=
 =?us-ascii?Q?eKE+nnKdBjgJVyoj8OqCOwKpOuLXllF+PJZPDFMbAyhvTMnS8Z+HVgGYEmRO?=
 =?us-ascii?Q?aXCiON4GPnbeL5KSGD7wmpbL/m/6cQ0gVdafMtY9f8vLbArpLlHLgaSUL7h/?=
 =?us-ascii?Q?bELBhiMEjq2kzuAVty1C4GxUoTZU8Qj1oUqr4FKOd+hOzBZXcvoScI629ex9?=
 =?us-ascii?Q?QkfEkQGBlNgObV0gBtTh4PKgeVQ1t+sP/RZaaU8D9BykzZS8T2yx8fTSBykx?=
 =?us-ascii?Q?uBnOGS373C3SuNYHH2QQKh6pl3vhh14owp5/+6D3TQ5lA0GY2qKuwgqCCQ2Y?=
 =?us-ascii?Q?BElM49eTa2KqJ0BFKvVliBgn79tpt58Uidt/KtDiUeQ6UT9wUDXBDjyr7rRJ?=
 =?us-ascii?Q?qFEqeF9E4n7ITrqn1eIQb1M6u8OZlKL2ZWTYiC5ocb6HM49BtfTPQwUEA+6a?=
 =?us-ascii?Q?7hcuUD34yPfrnyoLa0sIEMEsAcORNIg2CAvvfaxhbgzQJNPA+MG/dmZyxioI?=
 =?us-ascii?Q?AEEtgdMnQSpsdI0bmiq7xyLaii2ay2CCJ5WF/kwSsuhy3PZPcsxbf9DjaG2J?=
 =?us-ascii?Q?HTv2NlOx2KQBC8cAaDDV7gzGZLx+DWFJT0lhdgNJ29ZG0xQg4JBvTNPQqnbP?=
 =?us-ascii?Q?KNflYFrJXsDb6PbbqWShhv90/0f57XPI2/11VtxyLDw2V5dLZGvsuwKWZgKR?=
 =?us-ascii?Q?EU7ZnqaliC+DqNv4I49ZzHMYNGRtOXh6mR6X7gybrMgQ4GXf/DRvl6DIF1YE?=
 =?us-ascii?Q?w0YcAMlnZfidLex5OcTRDeXGxhy3/u7FCyFuvj6SyvtBY/ja9EEXQeI6iJuz?=
 =?us-ascii?Q?ZkJI20RRHPpeJWy3W2GD7TTDOR6xtafM1yUr9nkz8oV0LwbMOzA+IaF2JXRN?=
 =?us-ascii?Q?T2XlRtNsd/tLWNkHOEpPUgz4DMTdHDvCWL/1tf1maCLyvB9Rnr7YLVCAvvO8?=
 =?us-ascii?Q?WQMP0iinY48zYwmwjcQ88xpCsxY8SyhnqeA397XPCZ+DP2ZUwyUPKDW+LPOg?=
 =?us-ascii?Q?QFoJQ5uaO1quRGwsOa1ia8XZh1GYlfTLVVrAt7xfU2Rsd7Q+ZtpPhrlIqNzg?=
 =?us-ascii?Q?6CLwbd9NPmAqcfCO14eMOqyVARh5xtf4cVOoY70GVLvKs13gth0Pveyvi+0F?=
 =?us-ascii?Q?Q/AQrizwSPzBhJlNyOuLSk9FSyAX8T8gJpB0E5L56qN/h7QTpzNhs2wVQkPB?=
 =?us-ascii?Q?X3Ocu0jhRg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e47f20-bf70-4dcf-b7d9-08deb7538eae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:11:03.8911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXkR9+vHxmYMcPkXBIGe9kwn4VRlr8dbjeQoSqgx+DxzDEssnFGY/l7tajQqvGN6s2XR7dl+lIgzRdk3SLVsXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7209
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10694-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,nxp.com:dkim]
X-Rspamd-Queue-Id: 8789E5A9C15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:31:09PM +0900, Koichiro Den wrote:

subject:
    dmaengine: dw-edma-pcie: Rename vsec_data to dma_data

> dw_edma_pcie_probe() now obtains DMA layout data through device-specific
> capability callbacks, not only from PCIe Vendor-Specific Extended
> Capabilities. Rename the local data copy from vsec_data to dma_data
> before adding endpoint DMA BAR metadata discovery, which does not rely
> on VSEC.
>
> No functional change intended.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Frank



Return-Path: <dmaengine+bounces-10026-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E7Z2IbfA5Wk/nwEAu9opvQ
	(envelope-from <dmaengine+bounces-10026-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:59:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7AE426FAA
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05683005141
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7A35C190;
	Mon, 20 Apr 2026 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="awnlzdmn"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F51891A9;
	Mon, 20 Apr 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776664755; cv=fail; b=lCB76/QWRby7w5OcI20Vg9VFOxcKscC5RJs7dFzysrPJDM3suYfHwAjfAF9JKeDNWUQORXhe7RayveSQ66ZB3mljm+qo9k4UIcaxGRxrdcStnf4vhH/QNmXSdQJFxS+fQQ0VtrD9cCEiHk3RElKRp1k2TAXThg672RiT8Dm1clk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776664755; c=relaxed/simple;
	bh=WtXweP75+1rXYmWFjMWiSFpK1qQ5aFYi9jORnlSFDrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=et2xfxXJmBR5XWmYj9ZcMJLt4pJadfmmQ1i9rPYRvh5MSmNNlliCn7qriXGw/sW1p8FucRBzzrBIS97ElzUt+4rSyIjUi8NCI/eQFYqyhf3jCwB780cvIle5Qray/GAW2dsYQdID548PyZxLbspPmEIO025AUOUmch0EKf66Pc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=awnlzdmn; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1y1xWhRcaDoDCGVr6BqcjhNfcybNLvznaymv8yFjGwM5ijkR2QL/Px4ZA8xfY1dXkewlgO6jI2NugjJn+VUOOZ8EI8se7ptV8lvLStW/E1reL0hIWNncj6YbUR4bzVk49eoRJQ00ub/rsQEYiUSmWLuZqFykCTD1lxFuKoBJDh9xeTTRA+AjooZMCR5K2uigz1iHuYb5qgtlFNzl323lw5/8Fvs0NabFPjUQrDGLnPDSAWQ8aeiDKxsJqYV22xhX8qELa/M3fz2iyWlNgctvqspwTtSSGh81VFjwdLdr2/AiukOveO8TaLOSx17Q9R11xubizwhDehROpbvPmO1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi0wakUrmSK3JtiNKS9Y3zg7aebg8eckLLyMuCnPoBE=;
 b=qk1LDiWYP/nVZYy1Se2LnzVTKjkMYdvEJAPjtnlbpLcAJVgz10t+IKXdDGj5Yru0JxNmgnuDvT6kxnEh9tlXoy0WKhgdIQHm2jm29PJMP2GGBIWWVSjMU815ADTFAUDshIYp0S0JBRN8UHUSOZ8xkcWRGVwuewoDWunsrt7y7/BRlBRTxresqDkTNy8oJlxo5ZqvEf3+sCXOzB6ymcQGug+dsRxTsNILMcGcIiiAYXX+j++sX6xHD77a4TCRGjipsIrapDYT9s40l9KXBjQfbjFZHD0jZogbaOSis0aaSh7nOleF1Di7InRMKmWHjCP1En6rIg/66yzIKO6LM/ze/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi0wakUrmSK3JtiNKS9Y3zg7aebg8eckLLyMuCnPoBE=;
 b=awnlzdmn4K7t4nAqVIi0HfzXztbFulV/60npmdQeWNBnWBqsST/Hnigb3B6BvVEVNY0asd97yTEuiCVoQvK/XQ0P/4fddqg2Ry6bAbpTN+pkJNLxQf3JYBRALsjhxiobIKVl/Z4fzhu4Wk6dKJzRTRy+ZxcTNU59OLM6l/ZbCrpLjmcZaLDWgtAxJIYVC6VQsB8ktWyI/oISJL9onicwicgjsWJe5gE90DZpGfwLqFAs6CNduSmcgn9HgYefrL4/XRutTlc7yZ7N0TiGx1lLttw2mlXO1Ihtb/g2wNqYDr0Vh/ipAyYQyqAa33/n45pKxEGdULiPGWm+qmN5jphxIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11310.eurprd04.prod.outlook.com (2603:10a6:102:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 05:59:11 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 05:59:11 +0000
Date: Mon, 20 Apr 2026 01:59:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Fix saved engines array leak in config
 save
Message-ID: <aeXApkq97L93ZfAB@lizhi-Precision-Tower-5810>
References: <20260419140839.99672-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419140839.99672-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11310:EE_
X-MS-Office365-Filtering-Correlation-Id: 0648dc3e-7fa3-479c-7372-08de9ea1f151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j44pR64JN596k4haooKbh/xRS4ET6AJmMTwr/O99dfhX4/u7vq44ehZ+lE0g687jFjMp+Vk0aNMUkB3CI7c8sTO2kM3HM0LeuwYXPRNSMHUMCp+/wxecfMOAiwwCYTzKdaHxK5J4w/Rs23/v5++0yfe812Qo51EGqD0N/FQUQcx46VA3QEAnJxeB9u48nfM3nT8VBkZ3fFAKFC5rQaeF74a7X7Rd3yt6zGrq3T2eU6NFHTANx4NRQMJU8Wq4IdJbmNK65oa5vi30JHZVcG3F8Zg6pBcl0x2nRmqFlDsT0sGZJzfZjaN1E4BaeTb1Yf9+OkNzJ0aMtdDW1gJJc0W9HmUA9fxLWVRN8CVNfbMS1lHk3f99H5ZV91TJNjRX/rRe0OQ37gA0bYwEYSJstHd4GzSSg2zf8TLmSQYJQ+u7Iao1kheWAIWS7wOHkxwvDf+QhoUauauT1P8OMirSHgg2KmWyGio+qUZr43g/5CIfaoKQB3r0bvm2gU4B87+E7R1Oeb6GiqUSFRZ1an9ETcvV004K9V25e0kw2Cc2XFABuJZ8II8Z5iKGcPB7wZheXB1CtOc71U0g+CwIyzZQ0lYBdjbpZ0dfBAVKLah/CgzDZpPoU19XTUyfZWCk9mG7mdHHiNShYn8guf2Qq/k4kCKNX9L1hyCJVcJZfPnw+6TNlXOuI/HT4cr5qT4J7zil0hLsW8CInKHaTkBympharbJstyt/dSzNn6o96OvjsnLXAO9tA5fw6Ouo9TO1d5Yq7Nix1kl6mLfq6atHPJPGEkk1UMCMEmVP8nIs/1d4OLb2UyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AuSk6dKrCnwUpj7zvj2Rsh5ctA3x5T9Q54Mzckasa2jlu6ZfV3Fwv4Dvhh8C?=
 =?us-ascii?Q?8kuxk7+ogMkRFqIJQJtB39Qwf76LejrY7B7lufooCBnSOf8fhhFtktVLuSXo?=
 =?us-ascii?Q?I4oZp5sU+Xs0Ol+2Y4ZC5OMRg37TQ8z1CJwjj5HbThhLNkfMMoTgyMiLhdmO?=
 =?us-ascii?Q?tGyNdgJU8I05prrKPSMQ7mTn1ua5Gv7a99SCJpOJDcFCqpO0rrszaMS1JkIh?=
 =?us-ascii?Q?UEWmpKOSSwEgTFHm60oBQSCsTkaxQdZ5EX5V47MD+VRD9nPaHU9bTSh4QV2k?=
 =?us-ascii?Q?TKbRQ4N7iM208a1jLlsE+a3xyegkn08vQARWdHlVqCC6/i122LRQ3Y7qZcpG?=
 =?us-ascii?Q?Tcx9Q1hryWnLnwqiObNTPp1vzZ+BMgVKfPpdhayf2qVC4Mb19/7pfK8TMuv8?=
 =?us-ascii?Q?4z1c41hF9FhZmwNVCHBXPGy284mfY573WkSmlJLUIEh2yHbnHsYUrb/vzLBp?=
 =?us-ascii?Q?3R6mmB5GLnspKJQJXEpdffBPzQtgCpMLnVsV5PEaclr7X+8BGz+rsNg4vEcW?=
 =?us-ascii?Q?A0NvMvTZlPKu0pqMlpdMLjTO0mhLNv+1FMi4z0xoxIgE6SZtXx3zCS3wrFGN?=
 =?us-ascii?Q?cO7QEoca0h2L7h1bQ5yVsh2VlFjeACB4JujdhfkslH5uvhzwA1xFuJZYI8GN?=
 =?us-ascii?Q?xfiYXeyiMKvdi4sW0J3YlHnjF5PdtfAwel9KuNHpO/baB5raMLFEUBrVABgt?=
 =?us-ascii?Q?4PhFIc0mt0usQ/u5X9QjD5EPh3miD2zz2RYGumH5yASLnDn6U18Kmu/oy0F7?=
 =?us-ascii?Q?1QJTUrQtiGn+vnfSHjjkYuWeSKWK7SLIw2uqgMl+kJDDPyPAepWcGsF1rscj?=
 =?us-ascii?Q?4TaACFP2tcf+fUTzXiIbMxlyGnnRosgECB+bQ94puY5/SAN7OcoKkO3AYXxt?=
 =?us-ascii?Q?kHM0yNU5Ro+eud21dgFaDd7nhr2W+GwkbRJXeCGpH5xQCmpVqnhfJRuze9IS?=
 =?us-ascii?Q?hnV0hP6rUH+pkrKiucZHu0ZMH5IPOov7TmpKUWRY/OCieiHoKKE3CA9KR/r8?=
 =?us-ascii?Q?SuMbihZTuqBA9Nv6vuF+qqyGgcyQMvR4mFTdLqoXgboM6csKzA/dQZrfDlat?=
 =?us-ascii?Q?2MStQKFpsmyIsqvgXlsulday4z2xSNgHzTx5rdVteaMFuPc6ECOWZvPIuvRS?=
 =?us-ascii?Q?WON1FI6aC6NNTsZ9cQ+cOcIO5TIoakuCFrJhpLWJ+u1Va6Emq8HE1sUKlt+x?=
 =?us-ascii?Q?rzztG5WgOGrbxSzX6RuMk8CyFlKqP3sR/Abnxqk47KnhzCi8pFgCbK/r7Q1k?=
 =?us-ascii?Q?OCg/sBn7qmI6JGXEFvENXMVriSQEOX4/oL/DJ89IImsp8ue4ynqcSqhFOkNR?=
 =?us-ascii?Q?LPFTHCUJdJOig6SJRF3KWYLhK7IVl6eOXIn8JRhs3Xb7Pb0xEVPPWbrfbAv9?=
 =?us-ascii?Q?2Ene2uH4meuzwUuPoLAqo7ESd5kNSqgwBE68PyNxgEUSUxukBuYzeyH+H2Tt?=
 =?us-ascii?Q?AFCJqAMKReqKNEKueVJi5ldd9HJIh98YDum7CeaHI3bYqw3GfvkGa74Trqna?=
 =?us-ascii?Q?04lMCM9lcce//BC1ny2KI/nsdE5Is/RpveJuM4f/W+XhlFLWBdh4kVwPWlcA?=
 =?us-ascii?Q?0xQH+ldughYo6JhXjnBw2KYEVH9AjLK1zrzAgWS3AT0vvGj+Htj6FJXoKCLe?=
 =?us-ascii?Q?JPP1yWJ7L0VeQmwYk5Tz6cNTaSiGhXyghZJsslG22+5e2bUDl6onSzidVDAC?=
 =?us-ascii?Q?R5MyzS9pAM4S7cYvAfQ+XGaiOWVVB8kn6RNX1tdyNVDwHpWb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0648dc3e-7fa3-479c-7372-08de9ea1f151
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 05:59:11.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhsKq68oT8OK0w5pXxQfnbfDaZTJgi3KAEtKmdjSzNywsabzrdiKTxKo0xDAqhQiRVWv3YonijbskQYIyxvLvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11310
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10026-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB7AE426FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 10:08:39PM +0800, Guangshuo Li wrote:
> idxd_device_config_save() uses cleanup.h helpers for temporary
> allocations while saving device configuration. The saved_groups and
> saved_wqs pointer arrays are declared with __free(kfree), and ownership
> is transferred to idxd_saved with no_free_ptr() on the success path.
>
> The saved_engines pointer array follows the same ownership pattern on the
> success path, but it is not declared with __free(kfree). As a result, if
> an error happens after saved_engines is allocated, idxd_free_saved()
> frees the saved engine objects but not the saved_engines array itself.
>
> This leaks saved_engines on error paths such as:
>   - failure to allocate an individual saved engine
>   - failure to allocate saved_wq_enable_map
>   - failure to allocate saved_wqs
>   - failure to allocate an individual saved WQ
>
> Declare saved_engines with __free(kfree) so the array is released
> automatically on failure, matching saved_groups and saved_wqs. The success
> path is unchanged because ownership is already transferred with
> no_free_ptr().
>
> Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/dma/idxd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f1cfc7790d95..02210f16d391 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -880,7 +880,7 @@ static int idxd_device_config_save(struct idxd_device *idxd,
>  		saved_groups[i] = no_free_ptr(saved_group);
>  	}
>
> -	struct idxd_engine **saved_engines =
> +	struct idxd_engine **saved_engines __free(kfree) =
>  			kcalloc_node(idxd->max_engines,
>  				     sizeof(struct idxd_engine *),
>  				     GFP_KERNEL, dev_to_node(dev));

The follow code have problem.

saved_engines[i] = no_free_ptr(saved_engine);

if (...)
        return -ENOMEM;

there should not have an error branch after no_free_ptr(), you mix to use
manual and auto alloc()/free(), which may cause hidden problem.

Frank

> --
> 2.43.0
>


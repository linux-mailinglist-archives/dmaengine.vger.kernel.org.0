Return-Path: <dmaengine+bounces-9729-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kObHOYuWymkR+QUAu9opvQ
	(envelope-from <dmaengine+bounces-9729-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:28:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAF35DD22
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 982EB303F448
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE033F58C;
	Mon, 30 Mar 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IY2jJLxl"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4041A8F;
	Mon, 30 Mar 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883843; cv=fail; b=XR9X+6QON5Q5PBK8Q1OMTuvZEx9XvUC9OEP61l40wrSPtv2OIA7EBkKfaj41WRjHyOV206A82jVnpv21fWKm3v0rM0N2xkQvAhvH4CgjhBpiRJB0DZT9ZXUjmO22P1oYCqDd0lfLm6mdNH2YkqZ6cRb8KBwZqRT/FE/O87ZhkQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883843; c=relaxed/simple;
	bh=DkUEw1yZ913kN+lSG0z+/3RcAvP55G6FddcEc+nIDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c2kvpUYJG2+j8meYV2JUSXZJRLGM4/SZ8EMR66Rv+tQFVrrPdvs3bXtyiSc1U4M7xlsjAET3rM2LDIsJsEA063Fwh7v1N2lMC4qIr2MEpCJWEBFv0yimHKnpx/t/T3Ul4I6zobSLUqehpTAm0VB7ft5vzAsY/YyIdTQXzvDOsgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IY2jJLxl reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fie4o0wqex7+cMhNwFuT8Y8tTs5bGk24kAKA8jLQX3nZ3EsFjqVbW5kdZSAtpg9eSa2+T6O/gyiQGJ2IPHE8W3OFj5qs2F9I5U0Sx0I82IXSGQ+Rd/lAGA9IBxtmfvztSNCdRJF3daCo5lFCQIozNTZyn9xWE+wmoNENm7YDw1bXRLuzsD/I+5FN9PpWUj2gi2HK/mLJj3X8RLLXnzP9kzr8PhhI0pfgblGL0kYSeQllZ1BgrcZJ4Y/Zaaen7nxLHhNJ+Ztlj0orh6RyJCHFdkPLaCVQ+hQLrBzicOSIQB5Tn95NjM0UOURnktY1dUCSe0zFAM5DIXknXvS3EGoXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSVv3jTfY09fy0EjY/62th1HGHekryE2RkWH53CF8QQ=;
 b=KoQqoEYewaRpftHatIRqm63o4Jw56o/pQ3IpslJybbYP9QhN1KMtAL4VaxlKw/3TRAGdn1tCULrkqhabm5UVR0rywrzP4KZPdQGqexQXsMu3fy4Jo84FfpQCcaGMIcN3v5UrjS7yHxeO9Fcnm+jN+fFQOISFwu2nSsa+d9MwomSYh/xjWATL23xPdOj9/MGxtQbCPKXPNUHthao4d1eQ/FNKuNobSH2R1XX2exVmPOG4sIf9BcbiO76+OpGDs+3QU5zn6g9FDOYjiGj2CBGc6MwYq8doM9k56Tp9UtgDtZVb2zjOdDEQJWT0KSb5YNNmIe03LdAy+Kl10VoWJP7gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSVv3jTfY09fy0EjY/62th1HGHekryE2RkWH53CF8QQ=;
 b=IY2jJLxlXbY3CF7Dc8r03NPHjHnPGFnHD8HvnsD3BeSLUzCWWDlznDRnytQFSL6kTog+Tx1nVuvElbyTzrGTZwPqARlJqlsLfFMBGRJGRSOKjrxxOSV1bOFj43A8QUbOXFR07QoKsIc+lnfXzxz9FEjL+2P4RuaR9vLEV4vqgJpeEqVS8RpquekkoJHqDdolFU2/wazaDcafVnZf8900s11y7SeAyk9v/RhWDxrxYyQ1re0p/A5bJTUeLVezW3tnlYJ1WD32Ur0t87xV7tJFlk+KHRxqNy2esL4lt9X7Q7sT2DYMIcTJmPwU5oPCaN5j1IhU6ZygVd8/K++2MiVSTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB6875.eurprd04.prod.outlook.com (2603:10a6:10:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:17:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:17:19 +0000
Date: Mon, 30 Mar 2026 11:17:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 2/4] dmaengine: dma-axi-dmac: Properly free struct
 axi_dmac_desc
Message-ID: <acqT-j18bQZllwx1@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-2-021f95f0e87b@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260327-dma-dmac-handle-vunmap-v2-2-021f95f0e87b@analog.com>
X-ClientProxiedBy: SA0PR11CA0157.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: a785c586-ff91-458c-da98-08de8e6f6f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	H1YQ55xZAS1wut4EWwbq4poZ0d4UllVJFhgzvCZOHVXwKLmozr4q0ELoJoxsk6j6/ol+Zgw/HB9qqVcPJnXLY0x/3BbeiVE7obrC1p87cNX9cL0EghSu1lya62r2TWaAvsFGS2Q+PuBTRG++WiihBcvvZAGYD1LWqBZRHfH/OEdCC6+Tjp/lURx/QGeHRYM3NpC40edssSkd4DD5ngRAmrRc+WQ1nz2xlLt3/eHkLlgu0GFRlQmSbkmC6Cwgo2vtmbboluf9yPzlggIjCZni9P5LkdUtn4KXeWO+OSP5WgA5W1lnugrmpwphcIdV1l7Ah4MdyICNhi5W1ysQRUaYov1KVXYpzkjzq8uQ+zggjVcLPWC9kXE6ckqar+SS/zRHOqURj8jPD+h49VJB8ruZuP5PfIGF0q1/7MxvBdOniXTXwo8+264sS9CSUDrQ9xtJj68F3lvybn4LkeuY3E5+IRV2HijVedEd39v6Mq6m1Wg8CK/jY7qffMrlDyS32ww58/LOpenl3bReIBXQI5YilQfU19Sgs8T7C7GHn1MZPj5Wdx3hneEAaMr/QfR51PJvyXKTJzfYDZjqaFoTNV7EsghU7qsK7273a6Kbg/W05NKnxpLsq7QS9eryjAyoJ8v4FT2kfeuwstaQgYMzTPH27LSetPf/SzKUh+ZK1JXHkYLJtg6+4+cqRLAqQZUxMgxW7T8x/ZAMz5QznOGMRbtNtd/Soc+h3sufhRcm1KvUG224/XGqibkzY8q8mtsRnqgLjXUuIyMXaSlQDD4VmHeA4WQXV1BpSsILKyTi6QokdSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?C6cwLrtmtnkdPw9pj/EWf5TmvFW0vRH74H7fe/pn3J4IgAvauCq9caSt/l?=
 =?iso-8859-1?Q?+Oq4s7kmPHw1ybTRmIVOLOWlRL3m/149PfoiP5R5IZ3y8dmH3WBQ7WCOZ1?=
 =?iso-8859-1?Q?/3d3jenB5TtTUu2PCe8U7a9w1iaGl8vvIM7Msx3iywAoCg5p7Ht9NdFhgu?=
 =?iso-8859-1?Q?gtmIyiFOyfyxPlZC22xsI+5YyAOMMdkIIL1sGpaxsXKnfVP/uapvEcy/C0?=
 =?iso-8859-1?Q?IwCWemlfQnMYMYU3ZDZx+kpT9YR58B+Sa/gKimNkZXM9GRA9P6I6R3caGi?=
 =?iso-8859-1?Q?bJMLurXaqo6IGNsUj7WhlB8WYVZtQQrOZ/6pNpVXPodYlhaoY/733OvIO2?=
 =?iso-8859-1?Q?L5XH82WF06Mf5RIFvs5DiP+KTlg7Hm2MxYeYRaTtrPB4TX33PpFS67RaSB?=
 =?iso-8859-1?Q?DI1OtHSp6a/ahovr6kzD6EGAy8FXZpCnrR3uZjjmiUEqDiwnqGAqzTFQoB?=
 =?iso-8859-1?Q?quH3FJzFkcNVxX/aAh+q7Q+rPPDKQHgdR18tAip9qcNgsluHKQjGvlnD4/?=
 =?iso-8859-1?Q?cweV3pEG7/ipo3rls0/A98lShc8I7oIGWGLOiPK2+GD4MPNvE+5R6U4V2L?=
 =?iso-8859-1?Q?V6JAtLyuvKHDyJEzaapd9cVadGte5Ok0sPbasLQuvKkNbFp1mAjFF2TDgF?=
 =?iso-8859-1?Q?Lb37OinEYgQSTjDAjWmsWsYyPhtBY21aIolRHZrTZXljjswSIRL1t4BPAG?=
 =?iso-8859-1?Q?WEYkFDwX6+I+TDYLd7lhUBs61W1HDnwkEPyQGoWp7PQPgz7wHS/cczJN/r?=
 =?iso-8859-1?Q?cN0J4CP98m+PxlDRcjUv9WN/nbXA42qbs+UQFhmvNLStO6hvMZnfZaXO34?=
 =?iso-8859-1?Q?KvcI5yIBvFVnO8r/XzlMXJ+TOowtQcti+5p+yBdkNTeKNwQCPnkTzvJhMf?=
 =?iso-8859-1?Q?jVWaRd/eiZIkFfhmgSjHI8w2Ewfou4sIXmcr6+iJcurnWrlPuPYvsK5uWU?=
 =?iso-8859-1?Q?J+H3QbHBd5YDYKwezLo8HMK3hGkQ5RGmrANRmmVOz1iygSjsR/vO3FLQKI?=
 =?iso-8859-1?Q?aH7UvhJqqdMVUeNtzbvYpnGYdyz/CLIVGnMe5Zmezv5H5s5gK/6VwQp02n?=
 =?iso-8859-1?Q?g//B8zR8GQRT6amBCxgkop+s2VfyYaFbdop841qUTVTjVYy7ES59IOtSEa?=
 =?iso-8859-1?Q?Pm5BRvkLP6EBgWn5vJivE8bxgcKp3ZTrPyhoh1Kw3UtBxIRJDaFrq4i4TA?=
 =?iso-8859-1?Q?5Umt2mKBzoMrxizP1dcp6mDVK9VG5VTpP3nrCpwjT7NfgzWWylSyMh/MOY?=
 =?iso-8859-1?Q?FMbg++iMOur3tIBklIChcfrC3ucWjoGMTpTRBtEdiybLiBKa9o7PyKvtHM?=
 =?iso-8859-1?Q?VO/T+b/qmK2bUKtQXPwnEDUTWSaJJEexGuA4ZDq7SKu+xeK2bfeHySLC94?=
 =?iso-8859-1?Q?iyegUNweki3IJ7VoN96iFAp050AYk6t30EXc+MUFGQ/suQFR7tyKlvSlqf?=
 =?iso-8859-1?Q?7REJPclUhqtMs1GNKUy4gbuGbDNfQbGII/p6Kwkqbhm/NgkRCXWidVAYhh?=
 =?iso-8859-1?Q?bI3mAJ4sbWlz5pFTYHmiEDqgrVHm2k/Qh50daAWoS4qdW5ZagippYAvmg+?=
 =?iso-8859-1?Q?GewzrFRiq6AAyt18nfSotPH15fj+QoHP1Fw8OJnoFVilqfSgJQrRQTr87s?=
 =?iso-8859-1?Q?EpQ3dvnYZ4aIU0MvqHXUxmTGxhy0FWQpvh+un2KsLEO1RzD4tBYY7bOVSK?=
 =?iso-8859-1?Q?cQthRsogRY4YOdXYXBAAOKAaMeS5hioSugPjnFRaF/5hQNIbrozwoYBVWu?=
 =?iso-8859-1?Q?t1o3MWzjDHOX61ZkxFtcNOi65E1lRw0YUvMHqXdYpSWNPoNpe1UsUbTxD8?=
 =?iso-8859-1?Q?aDvKFwNAIQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a785c586-ff91-458c-da98-08de8e6f6f45
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:17:19.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FfgsK8Iv0Q35BtMzDLnT4fNswNIOVBfUi7J42SnP3OyI6LKQz79qJnqxv8G5ssv+qqr9vEXBUO5cgJVgXwPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6875
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9729-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86CAF35DD22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 04:58:39PM +0000, Nuno Sá wrote:
> In axi_dmac_prep_peripheral_dma_vec() if we fail after calling
> axi_dmac_alloc_desc(), we need to use axi_dmac_free_desc() to fully free
> the descriptor.

Call axi_dmac_free_desc() instead of kfree() to do fully cleanup at err
handle path.

Frank

>
> Fixes: 74609e568670 ("dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 45c2c8e4bc45..127c3cf80a0e 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -769,7 +769,7 @@ axi_dmac_prep_peripheral_dma_vec(struct dma_chan *c, const struct dma_vec *vecs,
>  	for (i = 0; i < nb; i++) {
>  		if (!axi_dmac_check_addr(chan, vecs[i].addr) ||
>  		    !axi_dmac_check_len(chan, vecs[i].len)) {
> -			kfree(desc);
> +			axi_dmac_free_desc(desc);
>  			return NULL;
>  		}
>
>
> --
> 2.53.0
>


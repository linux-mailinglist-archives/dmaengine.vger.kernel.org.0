Return-Path: <dmaengine+bounces-7480-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F134C9E4F5
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 09:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB093A49C8
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71B52BE621;
	Wed,  3 Dec 2025 08:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aREv94sn"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010061.outbound.protection.outlook.com [52.101.228.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92D158535;
	Wed,  3 Dec 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764751990; cv=fail; b=Xwm0tMFsD03/zDKyGvT5IU6XdJEDlnnDaRP1cwWxdy2+1R/Kmzfne4PCzrEF8VoGZ+IAgs9HKlLiCm438BxFCFKGc8mhScj+gc1Nnwfe/ZlxWWFzuP1JCGqrmOgHyKW0eDTMrWAUxIE3Wtl0mEG/iQl4xQtpnNWEaurL0ROU8nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764751990; c=relaxed/simple;
	bh=XJRllXkOE3XRNaWQ5pG6zCZxqu9oPVIHNpmMO/MxZCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=URf61SlpuMSA3GWhsnVvbxbGszxzmHqJpemfXGCCacYCuGxYP/7ZCEeIy8kB7ocbLVRvKm28M6pRNKzEs0IJPChtITMsL6KSGL8WzHxK7CwJejWZSHSrCs7LLKFkH2gqplRZzvBCieTtQGirWwrMOHSOMTpRRi6eUoD5q7+nBPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aREv94sn; arc=fail smtp.client-ip=52.101.228.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1NgWZzgPGEGoB0kn8CafhYxxdedHvxEDfefIG9cgVTGVEdbVVcpkKNmV8hXa2RrG3opaafgIU4xkLSYFM1Uqir8TuzV4Dkn1izRvW/pmj6WUxHSoxkxo0R5iwTKa5k+q8oC3AXyQFmJNPJHGX1kdAuzYJ0atT1Yunm3DgTnaM5E+QNZ8+XB7/6aq/ScwOhFIZd04yzdQDr2a92mU8q1KzXPQZhkVcF/FxtfmTK3l5YxZWz8a1pzogoTIXXOmEIlg5j/1N3QuZYBkcXpy472M1WXm+jAcSfqRvv1unhTvrIJ+G+yRVZp079MWVO4haRSKz/lXxkMOSPgSZpHpxekJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19nrpj3k8bDR8gJIgxMN7y7/6ORO+swCEY4CriR6/qY=;
 b=hcpe+YgsJG9itjfH+WkaIiU9AGZsfjY+93UWtcczm/2X3POuFTdqTMhhH0DwWIekb7dQjoFiKPtVJdyulYDF6YUSsdCv+xLQWpkRrnDA+QmLwkFMETjvK/t9tL0nED07UjIRdG3rJ9dc5BQbb/akvNlQ8lWmkgCWE8Wdpf4whMnpRIbHQ7HIWx1DmrxRdtC7/vc70WYUZB9l7R3EUuDdcNqvrpxl6aCS0wPhvH9t51i36dLdFfYXPjOGP13X9OsNc3u0y33N1sfSV4Fnj3Uz0URLGb2xZc+zajAUrkCpIjY1J1mw6b/dkiMVW4l+L7/n1OV0YhYDbsMBwUomnKKlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19nrpj3k8bDR8gJIgxMN7y7/6ORO+swCEY4CriR6/qY=;
 b=aREv94snRkVo2CriHyWkfMP3o1SUntAWiqmFVSZiwf5nHRBVakJi7ocLaOvz8a5s2rbmjFp4LQ7SQzLp3IPgs8F6NqWeIiARFKJuha8gge18876AeuqBzbrTsjMi2hsYOc/uEK+TsjmynoAaGdEdOa5SJHbM73btZUEKE71PW58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4934.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 08:53:04 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 08:53:04 +0000
Date: Wed, 3 Dec 2025 17:53:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ec2afd-4d49-47d8-a863-08de32495f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/P28R6i3IJGUMrZw6LuXjCBkM2Hd9+m2hOakYPfWbEYOSCxbtm1QnvABFMd1?=
 =?us-ascii?Q?0IqhnT6ypf2HtbmvDoemG77FdHowDxUTCljlyNdarv3vXS1krFO+FFY4ZVtr?=
 =?us-ascii?Q?igVXdSfsmbGgk8CdEU3ZyC6lVRF7uo1TrwkMqTD20+s2n4IWnfE7epjJtT0o?=
 =?us-ascii?Q?xn6FExGir71zhh5YhLNdQYOHqnJspPBoHZZfOPGUdpJw+DF2XOaf5kz9o3gy?=
 =?us-ascii?Q?1UsZRDo1MBRWWj2j9TvLBvHe20wtdYtYYGN+ifO4FNojcxqAMaJxvkatuMST?=
 =?us-ascii?Q?pvSM6wwb6dAUMVJKD7FlijLlXvL2WtipaR+JL5vbbCaCXt2sUE7eYA7B+4zw?=
 =?us-ascii?Q?RkcNI18ARosgDsYb6amjdXCfdPic9rQ5Qm10YX4QfMkE0IS36/BhGMFmHtqE?=
 =?us-ascii?Q?y58dBEwGR5dMLKr7oq3zNEGWNJxQ/sjcg0XG1xrmj85sjnGje4rib9MBgU49?=
 =?us-ascii?Q?6k/eFgVCFtdIsX/+ywzMjcdywnanrnjL1mMk/fVahaq5KYShZrx/+eZvdQwR?=
 =?us-ascii?Q?VuhTgo2z7BdFApPZSeTEi3+WxivqdnO2T33W/tFnSUWAXBcmF8qOBpIQDTDE?=
 =?us-ascii?Q?Vbq0IAm592elNRh4fAxPmncySq+L8MpcpQz5X8ZGdpdXh+qtW6i2IFS0gkO2?=
 =?us-ascii?Q?GrEii7eH5c0QagYq1PN+gfDmvY9IaguG10krrjlVffOSo6HTGCbQ0JIC6xv3?=
 =?us-ascii?Q?b4k91ngpR/LeV8EwcWuqBP1JmQgo3C6ZtJ9/IOIps9xmq2+PQUtWN8VDZ0wZ?=
 =?us-ascii?Q?A69HxX1/k34kC/zg6NCsJ4+/3WH8HND+b6mpZIDfBFII5BUXy6sWWmHhBqZx?=
 =?us-ascii?Q?tHFp2M9juBbOcHxshqUSZgkQS9gt7WoCGRzxfRjWmK/Wn0n9ZXlVHC2rjEwE?=
 =?us-ascii?Q?UbsuzRgAUUeu02pwZrOPFlZLUUE49/V13qQ2pInBHUbr5oda1gozESOoVIol?=
 =?us-ascii?Q?yuWtQHiYFY0YwvnTR3Axy9NLbyAvLRhHQU9C8gyJlu9iGdNfxgtHkRQResmC?=
 =?us-ascii?Q?0bLoOUtfdouDYXWOSZtoGpjPlN35hovEEFcYZv5a4BbjcbQO3jK8XhVSbKnz?=
 =?us-ascii?Q?TWFTgLLvn5Ais1PAGZmHzdFPH63QNT09Tba8TlMKA9wRuMyQWvd0GE8ARixT?=
 =?us-ascii?Q?1jm6N4xItUfwSh9d5jqFnkiLFuhMDUA+ySLooKTLz3/s+9a4bKXlZZf0wSeZ?=
 =?us-ascii?Q?x5wUj3Mnv5U9sxL860VAaE2RuF3+MtrJWh6HNp0Z1igOD/jaYldSi0km8PXm?=
 =?us-ascii?Q?VJn2y0zi5iLNm5oDegkqXqP4LCCdj3uA5xmdmHWymGpi5Fs0DI1n0uKFnClv?=
 =?us-ascii?Q?81WCOKNybxizJVehZh5a7VM9MxpTdvVlf+yVf9P2vGB9B1Qmu3ldKlTY2qR5?=
 =?us-ascii?Q?X1MByTwV6AiFcBQGpGOnvFryWTLRlI7FJSstyy5WMUO+2XWUxoWauaVDi/bX?=
 =?us-ascii?Q?cCvE3vAU5R5JYKFhlTCSGsLoK5NXLxw3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IKZYEtD4YPuIkQIbT6b7oyXwI6DvSgFgpihlwE8NFVoHkDmPn7mhFd7geGBY?=
 =?us-ascii?Q?YBT13+pfdNYfHSyickB2VdzuIR2kuUfhtflBIbuW+bGtt7HaLx2pJpmD/Dyq?=
 =?us-ascii?Q?Kc4+P+aVpXduz9UFryaNAxM6sxyg/63F0jNiLfORBmTtQRLkdVOKUllaUBQP?=
 =?us-ascii?Q?ZhN6f2J/rxUu225ji3SBXmdniTaFvdy0l43PKBCHZM8qPFl7Byzs8Sk+6gw/?=
 =?us-ascii?Q?xaIcCLgoFIVH7m4+rqjLniYX/A4DsK7XDhKIVpkBIeOQ1qmRCVH+PaStyF2Z?=
 =?us-ascii?Q?rcTBvxQCBnM0uNybeva7C84VQ8/KYAeyu4WVh3dZg/2nUQKeRSRTqcD6uFda?=
 =?us-ascii?Q?4axCGSV4KvOzcs75A/a6KtyHRpWfnuLe9tHbxk8a3yX2UXCrV7BB2CNgGr5L?=
 =?us-ascii?Q?s8itmT8AAK15pEhnRohFVkBcfZKgTwA/goTRBZPg5X5HzhD2ZeX/PlZp74IX?=
 =?us-ascii?Q?zqC1TTTupGstP4uI97vY8iipw2nOHUgR4KP2troBELBnAZDvPm8hbQIyrEfV?=
 =?us-ascii?Q?R0/Pb4ExN6CyLegpvW80GMHhK7ka9d+3B0GDYBUfDUg1Tdowkit0PqeV0cQe?=
 =?us-ascii?Q?/GbGkndUkWKrmyK8ucvB6q5j7d2q0wbzby8vUK4ohzN6YIDwJ3mL+7m0EBb6?=
 =?us-ascii?Q?BWt3xzVX9I/zQONnaDgvG3tdmpXbp7Dj03x6KNagUQrbL+5rMQerhCp/Hyf/?=
 =?us-ascii?Q?gsTKtMx6+NSSKy3Mxd9Hw9kydj6hs0LPz4N3HORKnfu3xpT3qLluzmrZc4yc?=
 =?us-ascii?Q?zKWK1t2Z7mNhyhWD54ud7wf+5Hwhzjv7Xrn++wi3qld1rnriJvdIisR0GSwn?=
 =?us-ascii?Q?L3SzvJ1z3T5iCeZ8mj5JUXC6Vcb3NXG7tyofLYEf887nalJBzYQGLspu9iYl?=
 =?us-ascii?Q?YBkDkOVFhCPfIXjIEOco57pQCPbfxGqTv87E6fIr4xpykLZxCJItIM11kfQv?=
 =?us-ascii?Q?wTOrqRdX/czASorDhIQ3Fo7Ye3KQ+O247jezl29Y4ggp670wQ14ZsrM4fzq1?=
 =?us-ascii?Q?EK2DT0A/Ck7CES0b0ztX7JnqlOU6NDn6xR1TDkwVe9VDbMRKoltcx3CzAvkT?=
 =?us-ascii?Q?y1Ffd/QtBV/CCN9RIv+M2LNQpL9aZ7vwAOh7K24sD6dLrCdcr3QtjnFBrIyN?=
 =?us-ascii?Q?vxTtXOEuCI3WetCP3xn7Y8YgxbLTixwHNWOIH1R9MozQxrPqcZSdDNOOe9mR?=
 =?us-ascii?Q?SlrQ5QZ+qyW2Gicqy+E887ScfkjQFSttYflz9e2qd4/yulzi8AMA5HKcQElL?=
 =?us-ascii?Q?9w8Q2Eb8Ks0gxD4QwK7opDMlCKqtc3hSiNbxKvzrTp6CyASdw9xfc5OVJWi+?=
 =?us-ascii?Q?JCkQcAIILAgaxCR4lLmYAYPFmTjrRgxQOAedzl0cEozRhzsydLHWeZgM4duv?=
 =?us-ascii?Q?YpQgb3LBGmZ6jRbMQkj05J1aWFrBHvGN7+4TJJgqtbpKDR8KwWhfViceOH53?=
 =?us-ascii?Q?YVQDAhbwbJwbQsEQwZMeBsxPeFaXtg8VY29OLM23peEleumVZGSGTfEp3ibx?=
 =?us-ascii?Q?dt63rnOHmPH/v9EqjYxS2WqlCAx4yGffMyzJogT1Yj7kjFC2c0t2fRyYjs4I?=
 =?us-ascii?Q?WYqSrHLNnoA3qKYtmgQWkQ3sfo6fHCa2TkPCH+jmxYzHtss5JNLA7/K52QeK?=
 =?us-ascii?Q?kSEpevyg1Hp/6DgAb86EI88=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ec2afd-4d49-47d8-a863-08de32495f15
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:53:04.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woDHlAZH7AOGLjN42nKAUiA8n5v1UXrO72/h915Tq/SEOK17a/Vbft901nSlI7M+s4BFGddheU5pyVrhUg5y7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4934

On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > located on the NTB endpoint to move data between host and endpoint.
> > > >
> ...
> > > > +#include "ntb_edma.h"
> > > > +
> > > > +/*
> > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > + * backend currently only supports this layout.
> > > > + */
> > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > >
> > > Not sure why need access EDMA register because EMDA driver already export
> > > as dmaengine driver.
> >
> > These are intended for EP use. In my current design I intentionally don't
> > use the standard dw-edma dmaengine driver on the EP side.
> 
> why not?

Conceptually I agree that using the standard dw-edma driver on both sides
would be attractive for future extensibility and maintainability. However,
there are a couple of concerns for me, some of which might be alleviated by
your suggestion below, and some which are more generic safety concerns that
I tried to outline in my replies to your other comments.

> 
> >
> > >
> > > > +
> > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > +
> ...
> > > > +
> > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > +	of_node_put(parent);
> > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > +}
> > > > +
> > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > +{
> > >
> > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > just register callback for dmeengine.
> >
> > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > callbacks handle int_status/int_clear, I think we could hit races. One side
> > might clear a status bit before the other side has a chance to see it and
> > invoke its callback. Please correct me if I'm missing something here.
> 
> You should use difference channel?

Do you mean something like this:
- on EP side, dw_edma_probe() only set up a dedicated channel for notification,
- on RC side, do not set up that particular channel via dw_edma_channel_setup(),
  but do other remaining channels for DMA transfers.

Also, is it generically safe to have dw_edma_probe() executed from both ends on
the same eDMA instance, as long as the channels are carefully partitioned
between them?

> 
> >
> > To avoid that, in my current implementation, the RC side handles the
> > status/int_clear registers in the usual way, and the EP side only tries to
> > suppress needless edma_int as much as possible.
> >
> > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > That would require some changes on dw-edma core.
> 
> If dw-edma work as remote DMA, which should enable RIE. like
> dw-edma-pcie.c, but not one actually use it recently.
> 
> Use EDMA as doorbell should be new case and I think it is quite useful.
> 
> > >
> > > > +	struct ntb_edma_interrupt *v = data;
> > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > +	u32 i, val;
> > > > +
> ...
> > > > +	ret = dw_edma_probe(chip);
> > >
> > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > dma engine support.
> > >
> > > EP side, suppose default dwc controller driver already setup edma engine,
> > > so use correct filter function, you should get dma chan.
> >
> > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > so that RC side only manages eDMA remotely and avoids the potential race
> > condition I mentioned above.
> 
> Improve eDMA core to suppport some dma channel work at local, some for
> remote.

Right, Firstly I experimented a bit more with different LIE/RIE settings and
ended up with the following observations:

* LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
  DMA transfer channels, the RC side never received any interrupt. The databook
  (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
  "If you want a remote interrupt and not a local interrupt then: Set LIE and
  RIE [...]", so I think this behaviour is expected.
* LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
  design, where the RC issues the DMA transfer for the notification via
  ntb_edma_notify_peer(). With RIE=0, the RC never calls
  dw_edma_core_handle_int() for that channel, which means that internal state
  such as dw_edma_chan.status is never managed correctly.

> 
> Frank
> >
> > Thanks for reviewing,
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > > +	if (ret) {
> > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> ...
> 
> > > > +{
> > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > +	spin_lock_init(&qp->rc_lock);
> > > > +}
> > > > +
> > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > +};
> > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > +
> > > >  /**
> > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > >   * @qp: NTB transport layer queue to be enabled
> > > > --
> > > > 2.48.1
> > > >


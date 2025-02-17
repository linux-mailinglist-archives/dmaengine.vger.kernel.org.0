Return-Path: <dmaengine+bounces-4507-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C0A37AAC
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 05:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A86D16BCE3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Feb 2025 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D6188CAE;
	Mon, 17 Feb 2025 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+pbrtxY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBF18785D;
	Mon, 17 Feb 2025 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739768362; cv=fail; b=ohj2z/9CN8t5PmPU1MOWdUkO8AE3dVIh3mfIkcGmG1OYP526mF+x4NgvBVYCDMI9cj5qobj2xIifZHKDqJzgPQnygfJinqd4lIOAgs7H/+48AgAYN7MafPG3QajBVu1/0GhLW+SPJQgjOcjglJl//bxBeR/LjoH8I9e+iYqkLqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739768362; c=relaxed/simple;
	bh=T2tIpDSYjOLCv13KrepVki//8IxO6We0Y/VRxlObMz8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=rm831ckH3sXJ+fsjzjyUowNUGK3qUo9fk88cye64p4EdP75njlgq9vvJMxfaoIIr30FhJX9geyntbueqnORJ6ou1JupdQLD16jFiSI91gj0mXeSDdgBdwHVqp1u5dkB8cAczZhAluE+oVL2tHVyzW5w8NeF+SSOHDOUs0XqKDC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+pbrtxY; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739768359; x=1771304359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T2tIpDSYjOLCv13KrepVki//8IxO6We0Y/VRxlObMz8=;
  b=c+pbrtxYK4YS8OA+hn/jvwV1gj4BNzCfepT8aD/UkgB7zAEWWxfjAKWO
   REPAhyrkMNhQUTXup1arrxen4Pn7TsFOkesylED2UNlC9u+rnZVjcHglS
   ptnUO+t2H4t/CmCU30PtbmVCYTTxESrC+FKCV9a7P7PsIqGKfibImkBtD
   r2m07WGFfm2JqIUIvKHS79G850bdGZ5uBrayPI2NMsi0vqBuvjq1U18O5
   WqdDeTg/4FdxG/lid8Cvzu8gpq/5G5orfxF3HsoPjsvaOWkO96tUu5UwA
   W3WkHh+wboywM4wOukobj5U67DAQsdycMKGZwyaPoYfuzEPps4XQoJJgc
   Q==;
X-CSE-ConnectionGUID: wWPA6VCCSY+zamaM45j2Uw==
X-CSE-MsgGUID: C8njaSNZRjO12vA9qEYOiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="51422704"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="51422704"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 20:59:19 -0800
X-CSE-ConnectionGUID: YNdQlS0PSjOeCXsJLzhSqw==
X-CSE-MsgGUID: zTaTOVHXTdOaQt2R5zjTbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118166954"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 20:59:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Feb 2025 20:59:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Feb 2025 20:59:18 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Feb 2025 20:59:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL29MDYhhuXxJujadpS6TxVr5ngwJr0Bg9dg8NDfbCbYD8SEPPOCnjliAURmEVU9aToyDgsCaw8yS0+htfX1v3tn9740CNzKcbF4wLNAYy24bS8xMTsSb4iDKjw3Rhgg1+uLMlEk3WHlsrM+CMDjNmvlEwSkkIAxf+OpBZVgTHiTByJgEmh5k52SIfNtUEebDFxcK/1120B5NkQ/UudMmhi2Pig4sidkTe/HrALX9QEltNCPoAIwyJyfLhua5jmhgRWbn05Cj3aHK2++thzSnOIiPrYVJVKJm9NOMIGw9JFd+7sNkn/iyUIi5d406cyQ1K6lEWJFXTw6R38EeN/njQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9b5087C5+DprYubzgG0bra/1R2bpAQM6u8OpRaG4EI=;
 b=qJ4Z3AXBOgVWKv3K8IFJyf8kqLc5fMPr/zVx4xhoIm3DkFEAphVIIeWuOWQvil9sLMxe7hxhPQU/UoXhBQRMRN4/zQKV2GdGfg+ksVBBdzALpw/Pi8dd8ffGBbYS2TNYBMoOKooGeqMxsK7RJzsEc1N/5EZhHWWC7aEwRBmOxqUD7I0znQ+RyQXBEiZh260xGzohZ7nLhpHUi2Tm2CSz3+znvfADV6J31yMmFoK9lxcbQH+qfZZrwItu1lXQMmb4hMGdAAVHFzaBJbKFlFnYS9OAPnF6L90S78WuoddzGsK6zTaoYrtnBvO8W8GyRObbLk/w+22Ih5GDUQ1xRo2EOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 04:59:15 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 04:59:15 +0000
Date: Mon, 17 Feb 2025 12:59:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [dmaengine]  98d187a989:
 BUG:KASAN:slab-use-after-free_in_idxd_dma_complete_txd
Message-ID: <202502171134.8c403348-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: edea5dbc-5d86-4467-a121-08dd4f0fd3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FEqQr21z+1HsdUlU/DvtSHqsFxpx2z8o7NqCDPCgDc7HsaAhfLYZspGNIXA2?=
 =?us-ascii?Q?VOxib4/fdx7ov5vz6cjVGDAQqMXgvP5K1vQbZVDMTL/2ZmhQGNDD3lkjsWbv?=
 =?us-ascii?Q?9gyHLj7US8pprGB+jQNFDAK9T22YqEKmaKKFu095Q9bp71aZbDDFCVVImfZ9?=
 =?us-ascii?Q?H8AiC5H30zV9JyqZ7ekj+b36/Kg3STNWhzLeeDbSWierYS+5UK19Odflu+Mu?=
 =?us-ascii?Q?cyqC9SCXwaK3yS/5tX6IY9xG07iadjC86oltNGPBT9E7lV06vxtA9XjkdRyS?=
 =?us-ascii?Q?bDzEjEZVf98qUiRxjWnJ2DB897qzso+QmVFOAbqbqXZJILz9Zduz0OD9u1vP?=
 =?us-ascii?Q?A/EIcrF64xMgZZTvaXvwPucmc8+ElCpmcbwkr00Qz8ZUWnreqTFiU6Vt3eJ1?=
 =?us-ascii?Q?8uQ1B1pf9SBtaHYeWXMKn1wAJ550KtIEEFq0SRmJCrxb/TvW5Z5W72TI18zJ?=
 =?us-ascii?Q?4j8FBkciaDCmvL2MsAMiZW0nJ7gpQDrmi1sdZU/F3UsS1TaNv4qSmJ0UmNd9?=
 =?us-ascii?Q?NROiuxSySY/IjVioLbR3b00zWa7dD4mhp+eYO+OIQj1sf7wHx18h8c1rE43F?=
 =?us-ascii?Q?EFFHVKVx/Txs+yTQLztT6/2tZ3Xkec8MS61lDh8vUkXFA6syy2LfWJsbmGRi?=
 =?us-ascii?Q?y69wl4VUkwp9mpy7vOP6mmt9RQRN0ZcyWCl1kEeUORJ1K6azR8y2xkU4BUsX?=
 =?us-ascii?Q?HEuUkvjuABf2gOCyDI/7Uy6pyI9RoAO+cJ2p2OdT/jwjQ+vQfs09kUcbR5zk?=
 =?us-ascii?Q?K0ejOHU5i0kz+BQKzFADQ6dQK8R1X5+pwUrvbko1OqbU7n9AclxWbtwDO2Pv?=
 =?us-ascii?Q?5JUfcAj0+7/HUa3kSmXtEaUagqO0TPySdYzywfFv10/GqzZHfC7wC3OlykNX?=
 =?us-ascii?Q?L4Vp0z7zlabvHn0LES5EDjNX5J/ocdhtn+u3FIh4Rz1qCfHuWvUr8tYbUZ1C?=
 =?us-ascii?Q?pMNcH1iS+05rTJFUkAVNLGwpd6MnPF/CUmRAF3uYe7dBBbJj7CqSKWrPAOZi?=
 =?us-ascii?Q?z9CVns5ceJYRVFPNR5NcNHVXKynpdUgKtO6va2B4OheLey/Kx3i30HES263r?=
 =?us-ascii?Q?dhjC1FIUqI/k5IcHOCStRHZo+RESpLmMp8zM61HVQ+tSrxU72KcAmDpyHaH0?=
 =?us-ascii?Q?2h/TspCQH7/1sd/bBI91VwAEaN9n4wRPJIF3voq+0y4G17m/ukLVGS/Lw/tH?=
 =?us-ascii?Q?ms2ugf/45IhvM6C219ZQnr5++/RnrBzmXmt9KBRUNxGB36cBcuryq5e3JmiF?=
 =?us-ascii?Q?T/Kh1V4GXWbekk55zAiM84/Q7zAlEHvZvkTUu6l1ERH9sG/6u2p9duQC0kB3?=
 =?us-ascii?Q?+HLCH0IlNoFiRWBN5J0IdpF8ITiwzTR+fK51DXr9VN4HNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wP+VIZmw6kH+grGtbPifnveO2JHbj1JNM7zEs3POaSB2Fx4pY4288ujPOjnY?=
 =?us-ascii?Q?RrgOaOgJr/2mhcS4+1l0u7/zZiecOyRyWdTOTReaeRDJVqiV/CMWufnlgBoQ?=
 =?us-ascii?Q?FdUxbjAHP18CNyu8Hy3I8MynGOMc/z9E7mthvcYl/5YiHfP3mAKRkQ5E5Dqh?=
 =?us-ascii?Q?RxEkTXgXwzYNh7u4fnXSBU1HrAx7DsYmNo5PmzF8YVUc4kfAGTIMkaRyxuP6?=
 =?us-ascii?Q?yi6pTDIe+/w8lzXMoc5hktBnIuEAD3PXNjp8I4dj6laHc5wzE19dySlK630C?=
 =?us-ascii?Q?/ak945L/uV0dq+2PEhbPRLOqXOQUCvmn+H6RG6+NUZ0LmQh5RkhEqWRLT5wl?=
 =?us-ascii?Q?alzQQfIuaqTtHBULetAcP9N6BVyDIgDQSvwzMjJrerJdMX3A+ERqbVJOXwev?=
 =?us-ascii?Q?Bk+GF0R15QyQD2zoWq6cyY/Ovl6lDFKPnnMX/dgGNW/GOeqc2/UwbG/+ACx8?=
 =?us-ascii?Q?J+s+lKlgmazMziQv0N2hRWCUoM25AOr9zAoAePXUCJGS7uyW9bTryoqEL+ua?=
 =?us-ascii?Q?wLTWteE5D5WsVUUN3jfYNAbMeVdA8wZp2ALkpkw0l3EqnZG/QCnNUKwQBnUD?=
 =?us-ascii?Q?7oxWhSJDCYjCWwAyPBC1ObGI1Az14R1r1F6c5Wtjwa/GYyB1DG9J27M1HkOj?=
 =?us-ascii?Q?4xXcZm2yQsBvurZ9lcxrqs5lFkCTbii/Rr5FGmtS/Ubrn4kCYu/XAlIOsHPt?=
 =?us-ascii?Q?HFUTidQ4M9/raLmCDKBrDGhAWyhMO2DNP5MdIu8MUXG3x+6xT6U9eCuEnhkc?=
 =?us-ascii?Q?yPUEL8GKK5aA9I+OGEA/ErKRRlCjSIAkW8+PSDjPcy35THOpQo225X4uLo1y?=
 =?us-ascii?Q?BuEkqPuSaXWhIw953K2S3H+jFszB94GnZd92LjBmM7Od68WxCQbVwkMLdOJr?=
 =?us-ascii?Q?r785+Fqv1/rfba9cYJjH3oPrs6N6BGHfcZ4B5THbN+Exg4FSvW2sLTC9q6Ar?=
 =?us-ascii?Q?aFWPjugSwRB8MQHxZ8MfM1l7XJiTbYJPtdhI1aZJC9dCq+M6TOATtBx5D7OF?=
 =?us-ascii?Q?msMbek2kyDYnLuLhgJFGxYTBgXwW2jXZRgRh9kyQoLtrn7z2KZosqCMlwnHz?=
 =?us-ascii?Q?UcoCiWhgd9j3lcel1KYSYUzK05+u7tPjQr7HUroIkUpcvhYQSp1N7JXU2N/P?=
 =?us-ascii?Q?IDniE1BJBJn4VOvcgzhxanWcCQ4j1cDQqD2MwfusOLUPXU83mX/E2r2bzuzD?=
 =?us-ascii?Q?PhWjaUk+kHHV6oUwG1JTAPk+Az2V15SP6z9b4+dfrHQxfxEEsTLs6WjeHk8/?=
 =?us-ascii?Q?313s4rVbuBOY5HPndy7USOPuavijCPBWmA7WX1wLmvi4W1C0s+e2onO0ee4h?=
 =?us-ascii?Q?5KNuNIFOziVfolDMZVnR0iiwcYY3EPhi6xm7rgf44kvDcDy4RyXBlV6Mjwcq?=
 =?us-ascii?Q?Y19p0diyyxJj9nec/VXYlfxjaoHTmA8rAwX0HztprkjcPWwHzVYnA7IRHDh5?=
 =?us-ascii?Q?CJc8xMDB5JrxzTLlAVAzxU+JfgIf7SJ4cRq2B7mEZJg8iMEylrnAtjLWATCy?=
 =?us-ascii?Q?iUpKA0pPO58kZy9m2T0lCrR1IXe7lh7XkmgR86ySZU/tJQqC0vfdnTbNhpk2?=
 =?us-ascii?Q?JNKLPB/ilAkP6L3F57O4KsHWMwBaKP6B+rxQ7h2AiUq0ydwBqePgb5+1t6Ma?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edea5dbc-5d86-4467-a121-08dd4f0fd3a8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 04:59:15.1494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxHuUReMXpnYAhT76WFSpG3Q4nKW02pUY6/wd+bUCZLl68334lHs12wULtaBkrKswK4jg7gteIRb7Z89IBUGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_idxd_dma_complete_txd" on:

commit: 98d187a989036096feaa2fef1ec3b2240ecdeacf ("dmaengine: idxd: Enable Function Level Reset (FLR) for halt")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      ad1b832bf1cf2df9304f8eb72943111625c7e5a7]
[test failed on linux-next/master 0ae0fa3bf0b44c8611d114a9f69985bf451010c3]

in testcase: lkvs
version: lkvs-x86_64-b814353-1_20250114
with following parameters:

	test: dma



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250217/202502171134.8c403348-lkp@intel.com



[   81.023244][ T1644] idxd dsa0: Active wq 0 on disable wq0.0.
[   81.040447][ T1644] idxd 0000:6a:01.0: Clients has claim on wq 0: 1
[   81.057589][ T1644] ==================================================================
[   81.067630][ T1644] BUG: KASAN: slab-use-after-free in idxd_dma_complete_txd+0x418/0x510 [idxd]
[   81.078535][ T1644] Write of size 4 at addr ff11000134978114 by task kworker/118:1/1644
[   81.088651][ T1644] 
[   81.092179][ T1644] CPU: 118 UID: 0 PID: 1644 Comm: kworker/118:1 Tainted: G S                 6.13.0-rc1-00054-g98d187a98903 #1
[   81.107286][ T1644] Tainted: [S]=CPU_OUT_OF_SPEC
[   81.113559][ T1644] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
[   81.127263][ T1644] Workqueue: 0000:6a:01.0 idxd_device_flr [idxd]
[   81.135307][ T1644] Call Trace:
[   81.139911][ T1644]  <TASK>
[   81.144097][ T1644]  dump_stack_lvl+0x4f/0x70
[   81.149999][ T1644]  print_address_description+0x2c/0x3a0
[   81.158248][ T1644]  ? idxd_dma_complete_txd+0x418/0x510 [idxd]
[   81.165906][ T1644]  print_report+0xb9/0x280
[   81.171662][ T1644]  ? kasan_addr_to_slab+0x9/0x90
[   81.177960][ T1644]  ? idxd_dma_complete_txd+0x418/0x510 [idxd]
[   81.185532][ T1644]  kasan_report+0xaa/0xe0
[   81.191118][ T1644]  ? idxd_dma_complete_txd+0x418/0x510 [idxd]
[   81.198663][ T1644]  idxd_dma_complete_txd+0x418/0x510 [idxd]
[   81.206004][ T1644]  ? __asan_memcpy+0x38/0x60
[   81.211829][ T1644]  ? __pfx_idxd_dma_complete_txd+0x10/0x10 [idxd]
[   81.219714][ T1644]  ? _raw_spin_lock+0x81/0xe0
[   81.225650][ T1644]  ? __pfx__raw_spin_lock+0x10/0x10
[   81.232151][ T1644]  idxd_flush_pending_descs+0x4a8/0x7e0 [idxd]
[   81.239763][ T1644]  ? __pfx_idxd_flush_pending_descs+0x10/0x10 [idxd]
[   81.247975][ T1644]  idxd_wq_free_irq+0xcd/0x330 [idxd]
[   81.254703][ T1644]  idxd_drv_disable_wq+0x125/0x2d0 [idxd]
[   81.261787][ T1644]  idxd_dmaengine_drv_remove+0x1fd/0x2f0 [idxd]
[   81.269441][ T1644]  ? kernfs_remove_by_name_ns+0x108/0x150
[   81.276508][ T1644]  device_release_driver_internal+0x36d/0x530
[   81.283969][ T1644]  idxd_device_drv_remove+0xa0/0x240 [idxd]
[   81.291238][ T1644]  device_release_driver_internal+0x36d/0x530
[   81.298666][ T1644]  idxd_reset_done+0x600/0x770 [idxd]
[   81.305332][ T1644]  ? __pfx_pci_restore_iov_state+0x10/0x10
[   81.312479][ T1644]  ? __pfx_idxd_reset_done+0x10/0x10 [idxd]
[   81.319737][ T1644]  ? pci_restore_state+0x42b/0x600
[   81.326774][ T1644]  pci_reset_function+0x1c9/0x230
[   81.333042][ T1644]  idxd_device_flr+0x34/0x90 [idxd]
[   81.339505][ T1644]  process_one_work+0x676/0x1000
[   81.345656][ T1644]  worker_thread+0x710/0xf40
[   81.351399][ T1644]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[   81.358381][ T1644]  ? __kthread_parkme+0xba/0x1e0
[   81.364500][ T1644]  ? schedule+0x75/0x1c0
[   81.369820][ T1644]  ? __pfx_worker_thread+0x10/0x10
[   81.376131][ T1644]  kthread+0x2d4/0x3c0
[   81.381240][ T1644]  ? __pfx_kthread+0x10/0x10
[   81.386963][ T1644]  ret_from_fork+0x2d/0x70
[   81.392478][ T1644]  ? __pfx_kthread+0x10/0x10
[   81.398155][ T1644]  ret_from_fork_asm+0x1a/0x30
[   81.404030][ T1644]  </TASK>
[   81.407943][ T1644] 
[   81.411051][ T1644] Allocated by task 3664:
[   81.416396][ T1644]  kasan_save_stack+0x1c/0x40
[   81.422121][ T1644]  kasan_save_track+0x10/0x30
[   81.427836][ T1644]  __kasan_kmalloc+0x8b/0x90
[   81.433408][ T1644]  idxd_dmaengine_drv_probe+0x2eb/0x860 [idxd]
[   81.440774][ T1644]  really_probe+0x1e0/0x920
[   81.441469][ T2471] install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1_all.deb
[   81.445747][ T1644]  __driver_probe_device+0x18c/0x3d0
[   81.445750][ T1644]  device_driver_attach+0xae/0x1b0
[   81.445751][ T1644]  bind_store+0xc9/0x140
[   81.445756][ T1644]  kernfs_fop_write_iter+0x2e6/0x4c0
[   81.460993][ T2471] 
[   81.466823][ T1644]  vfs_write+0x584/0xc40
[   81.466828][ T1644]  ksys_write+0xf0/0x1c0
[   81.466830][ T1644]  do_syscall_64+0x79/0x150
[   81.466834][ T1644]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   81.473172][ T2471] /opt/deb/ntpsec-ntpdate_1.2.2+dfsg1-1+deb12u1_amd64.deb
[   81.477183][ T1644] 
[   81.477185][ T1644] Freed by task 1644:
[   81.477186][ T1644]  kasan_save_stack+0x1c/0x40
[   81.477189][ T1644]  kasan_save_track+0x10/0x30
[   81.483064][ T2471] 
[   81.485576][ T1644]  kasan_save_free_info+0x37/0x60
[   81.485578][ T1644]  __kasan_slab_free+0x33/0x40
[   81.490842][ T2471] /opt/deb/python3-ntp_1.2.2+dfsg1-1+deb12u1_amd64.deb
[   81.494947][ T1644]  kfree+0xef/0x3e0
[   81.494954][ T1644]  idxd_dmaengine_drv_remove+0x1cb/0x2f0 [idxd]
[   81.499941][ T2471] 
[   81.506445][ T1644]  device_release_driver_internal+0x36d/0x530
[   81.506448][ T1644]  idxd_device_drv_remove+0xa0/0x240 [idxd]
[   81.514840][ T2471] /opt/deb/openssl_3.0.15-1~deb12u1_amd64.deb
[   81.516891][ T1644]  device_release_driver_internal+0x36d/0x530
[   81.516893][ T1644]  idxd_reset_done+0x600/0x770 [idxd]
[   81.521311][ T2471] 
[   81.526486][ T1644]  pci_reset_function+0x1c9/0x230
[   81.526491][ T1644]  idxd_device_flr+0x34/0x90 [idxd]
[   81.532161][ T2471] /opt/deb/libpython3.11_3.11.2-6+deb12u5_amd64.deb
[   81.534173][ T1644]  process_one_work+0x676/0x1000
[   81.539762][ T2471] 
[   81.545023][ T1644]  worker_thread+0x710/0xf40
[   81.545026][ T1644]  kthread+0x2d4/0x3c0
[   81.545029][ T1644]  ret_from_fork+0x2d/0x70
[   81.553070][ T2471] /opt/deb/liberror-perl_0.17029-2_all.deb
[   81.556818][ T1644]  ret_from_fork_asm+0x1a/0x30
[   81.556823][ T1644] 
[   81.556824][ T1644] The buggy address belongs to the object at ff11000134978100
[   81.556824][ T1644]  which belongs to the cache kmalloc-128 of size 128
[   81.563755][ T2471] 
[   81.566277][ T1644] The buggy address is located 20 bytes inside of
[   81.566277][ T1644]  freed 128-byte region [ff11000134978100, ff11000134978180)
[   81.566280][ T1644] 
[   81.566281][ T1644] The buggy address belongs to the physical page:
[   81.566283][ T1644] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x134978
[   81.573497][ T2471] /opt/deb/g++-multilib_4%3a12.2.0-3_amd64.deb
[   81.579562][ T1644] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   81.579565][ T1644] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[   81.579569][ T1644] page_type: f5(slab)
[   81.586307][ T2471] 
[   81.593023][ T1644] raw: 0017ffffc0000040 ff1100010c83ca00 dead000000000100 dead000000000122
[   81.593026][ T1644] raw: 0000000000000000 0000000080400040 00000001f5000000 0000000000000000
[   81.593028][ T1644] head: 0017ffffc0000040 ff1100010c83ca00 dead000000000100 dead000000000122
[   81.599459][ T2471] /opt/deb/gcc-multilib_4%3a12.2.0-3_amd64.deb
[   81.601514][ T1644] head: 0000000000000000 0000000080400040 00000001f5000000 0000000000000000
[   81.601517][ T1644] head: 0017ffffc0000002 ffd4000004d25e01 ffffffffffffffff 0000000000000000
[   81.607068][ T2471] 
[   81.612816][ T1644] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
[   81.612818][ T1644] page dumped because: kasan: bad access detected
[   81.612818][ T1644] 
[   81.612819][ T1644] Memory state around the buggy address:
[   81.612820][ T1644]  ff11000134978000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.612822][ T1644]  ff11000134978080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.620598][ T2471] /opt/deb/g++-12-multilib_12.2.0-14_amd64.deb
[   81.625605][ T1644] >ff11000134978100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   81.625607][ T1644]                          ^
[   81.625608][ T1644]  ff11000134978180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.625609][ T1644]  ff11000134978200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   81.625611][ T1644] ==================================================================
[   81.625640][ T1644] Disabling lock debugging due to kernel taint
[   81.628154][ T2471] 
[   81.652978][ T1644] idxd 0000:6a:01.0: Intel(R) Accelerator Device (v100)
[   81.656683][ T2471] /opt/deb/gcc-12-multilib_12.2.0-14_amd64.deb
[   81.658763][ T1644] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   81.674487][ T2471] 
[   81.676998][ T1644] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   81.677003][ T1644] CPU: 118 UID: 0 PID: 1644 Comm: kworker/118:1 Tainted: G S  B              6.13.0-rc1-00054-g98d187a98903 #1
[   81.692784][ T2471] /opt/deb/libx32gcc-12-dev_12.2.0-14_amd64.deb
[   81.694857][ T1644] Tainted: [S]=CPU_OUT_OF_SPEC, [B]=BAD_PAGE
[   81.694859][ T1644] Hardware name: Intel Corporation D50DNP1SBB/D50DNP1SBB, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
[   81.694861][ T1644] Workqueue: 0000:6a:01.0 idxd_device_flr [idxd]
[   81.702005][ T2471] 
[   81.711836][ T1644] 
[   81.711838][ T1644] RIP: 0010:idxd_device_config_restore+0xfe/0x1180 [idxd]
[   81.719149][ T2471] /opt/deb/lib32gcc-12-dev_12.2.0-14_amd64.deb
[   81.728120][ T1644] Code: 01 38 d0 7c 08 84 d2 0f 85 87 10 00 00 48 8d 7b 34 41 0f b7 a8 2c 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 3f
[   81.728123][ T1644] RSP: 0018:ffa0000015d5fbd8 EFLAGS: 00010207
[   81.728126][ T1644] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff823a331a
[   81.736784][ T2471] 
[   81.741169][ T1644] RDX: 0000000000000006 RSI: ff1100032281d000 RDI: 0000000000000034
[   81.741171][ T1644] RBP: 0000000000000000 R08: ff1100032281d000 R09: fff3fc0002babf0d
[   81.741173][ T1644] R10: ffa0000015d5f86f R11: 0000000034363154 R12: ff1100024e2c8a00
[   81.741174][ T1644] R13: 1ff4000002babf94 R14: ff110002c3a61000 R15: ff110002c3a614f0
[   81.741176][ T1644] FS:  0000000000000000(0000) GS:ff110017fe700000(0000) knlGS:0000000000000000
[   81.744155][ T2471] /opt/deb/libx32quadmath0_12.2.0-14_amd64.deb
[   81.753262][ T1644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   81.753265][ T1644] CR2: 00005571b074b010 CR3: 000000407c86c002 CR4: 0000000000f73ef0
[   81.762841][ T2471] 
[   81.772472][ T1644] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   81.772474][ T1644] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   81.772475][ T1644] PKRU: 55555554
[   81.772476][ T1644] Call Trace:
[   81.772478][ T1644]  <TASK>
[   81.772479][ T1644]  ? die_addr+0x3c/0xa0
[   81.779750][ T2471] /opt/deb/lib32quadmath0_12.2.0-14_amd64.deb
[   81.788975][ T1644]  ? exc_general_protection+0x150/0x230
[   81.788980][ T1644]  ? asm_exc_general_protection+0x22/0x30
[   81.798674][ T2471] 
[   81.801182][ T1644]  ? llist_add_batch+0xba/0x130
[   81.811306][ T2471] /opt/deb/libx32atomic1_12.2.0-14_amd64.deb
[   81.817968][ T1644]  ? idxd_device_config_restore+0xfe/0x1180 [idxd]
[   81.820540][ T2471] 
[   81.826767][ T1644]  ? idxd_pci_probe_alloc+0x1b7/0xbd0 [idxd]
[   81.836181][ T2471] /opt/deb/lib32atomic1_12.2.0-14_amd64.deb
[   81.844727][ T1644]  idxd_reset_done+0x1d8/0x770 [idxd]
[   81.851592][ T2471] 
[   81.860536][ T1644]  ? __pfx_pci_restore_iov_state+0x10/0x10
[   81.860542][ T1644]  ? __pfx_idxd_reset_done+0x10/0x10 [idxd]
[   81.866040][ T2471] /opt/deb/libx32gcc-s1_12.2.0-14_amd64.deb
[   81.874587][ T1644]  ? pci_restore_state+0x42b/0x600
[   81.874591][ T1644]  pci_reset_function+0x1c9/0x230
[   81.874594][ T1644]  idxd_device_flr+0x34/0x90 [idxd]
[   81.883600][ T2471] 
[   81.892543][ T1644]  process_one_work+0x676/0x1000
[   81.892550][ T1644]  worker_thread+0x710/0xf40
[   81.899811][ T2471] /opt/deb/lib32gcc-s1_12.2.0-14_amd64.deb
[   81.901950][ T1644]  ? __pfx_set_cpus_allowed_ptr+0x10/0x10
[   81.909670][ T2471] 
[   81.916481][ T1644]  ? __kthread_parkme+0xba/0x1e0
[   81.916484][ T1644]  ? schedule+0x75/0x1c0
[   81.931137][ T2471] /opt/deb/sgml-data_2.0.11+nmu1_all.deb
[   81.933252][ T1644]  ? __pfx_worker_thread+0x10/0x10
[   81.942644][ T2471] 
[   81.955692][ T1644]  kthread+0x2d4/0x3c0
[   81.955695][ T1644]  ? __pfx_kthread+0x10/0x10
[   81.955697][ T1644]  ret_from_fork+0x2d/0x70
[   81.962967][ T2471] /opt/deb/cmake_3.25.1-1_amd64.deb
[   81.969242][ T1644]  ? __pfx_kthread+0x10/0x10
[   81.969245][ T1644]  ret_from_fork_asm+0x1a/0x30
[   81.969249][ T1644]  </TASK>
[   81.969250][ T1644] Modules linked in:
[   81.981945][ T2471] 
[   81.988957][ T1644]  dmatest(+) intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common nfit
[   81.991926][ T2471] /opt/deb/cmake-data_3.25.1-1_all.deb
[   81.994039][ T1644]  libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp btrfs kvm_intel blake2b_generic xor kvm zstd_compress
[   82.001948][ T2471] 
[   82.008781][ T1644]  crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 raid6_pq sha256_ssse3 libcrc32c sha1_ssse3 snd_pcm crc32c_intel spi_nor ast rapl
[   82.031083][ T2471] /opt/deb/patch_2.7.6-7_amd64.deb
[   82.037471][ T1644]  snd_timer dax_hmem drm_client_lib cxl_acpi mtd
[   82.046363][ T2471] 
[   82.048897][ T1644]  snd mei_me intel_cstate nvme ipmi_ssif drm_shmem_helper
[   82.058188][ T2471] /opt/deb/libdpkg-perl_1.21.22_all.deb
[   82.066655][ T1644]  iaa_crypto isst_if_mbox_pci isst_if_mmio cxl_port qat_4xxx pmt_telemetry
[   82.075558][ T2471] 
[   82.084424][ T1644]  intel_sdsi pmt_class intel_th_gth intel_qat cxl_core idxd soundcore
[   82.094772][ T2471] /opt/deb/g++_4%3a12.2.0-3_amd64.deb
[   82.101195][ T1644]  intel_th_pci crc8 i2c_i801 spi_intel_pci intel_uncore mei nvme_core
[   82.108530][ T2471] 
[   82.117385][ T1644]  drm_kms_helper einj acpi_power_meter cdc_ether pcspkr isst_if_common authenc
[   82.120298][ T2471] /opt/deb/g++-12_12.2.0-14_amd64.deb
[   82.128818][ T1644]  intel_vsec idxd_bus intel_th wmi
[   82.137715][ T2471] 
[   82.141586][ T1644]  i2c_smbus spi_intel i2c_ismt ipmi_si acpi_ipmi ipmi_devintf ipmi_msghandler pinctrl_emmitsburg
[   82.145573][ T2471] /opt/deb/gcc_4%3a12.2.0-3_amd64.deb
[   82.148443][ T1644]  acpi_pad joydev pfr_telemetry pfr_update binfmt_misc loop
[   82.153055][ T2471] 
[   82.159772][ T1644]  fuse drm
[   82.166283][ T2471] /opt/deb/gcc-12_12.2.0-14_amd64.deb
[   82.172250][ T1644]  dm_mod ip_tables
[   82.174780][ T2471] 
[   82.180164][ T1644] ---[ end trace 0000000000000000 ]---
[   82.187224][ T2471] /opt/deb/libgcc-12-dev_12.2.0-14_amd64.deb
[   82.209342][ T1644] pstore: backend (erst) writing error (-28)
[   82.212775][ T2471] 
[   82.218701][ T1644] RIP: 0010:idxd_device_config_restore+0xfe/0x1180 [idxd]
[   82.221693][ T2471] /opt/deb/libquadmath0_12.2.0-14_amd64.deb
[   82.227705][ T1644] Code: 01 38 d0 7c 08 84 d2 0f 85 87 10 00 00 48 8d 7b 34 41 0f b7 a8 2c 05 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 3f
[   82.234257][ T2471] 
[   82.240814][ T1644] RSP: 0018:ffa0000015d5fbd8 EFLAGS: 00010207
[   82.247569][ T2471] /opt/deb/libatomic1_12.2.0-14_amd64.deb
[   82.252734][ T1644] 
[   82.252735][ T1644] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff823a331a
[   82.252736][ T1644] RDX: 0000000000000006 RSI: ff1100032281d000 RDI: 0000000000000034
[   82.258508][ T2471] 
[   82.261058][ T1644] RBP: 0000000000000000 R08: ff1100032281d000 R09: fff3fc0002babf0d
[   82.261060][ T1644] R10: ffa0000015d5f86f R11: 0000000034363154 R12: ff1100024e2c8a00
[   82.261061][ T1644] R13: 1ff4000002babf94 R14: ff110002c3a61000 R15: ff110002c3a614f0
[   82.266938][ T2471] /opt/deb/automake_1%3a1.16.5-1.3_all.deb
[   82.271636][ T1644] FS:  0000000000000000(0000) GS:ff110017fe700000(0000) knlGS:0000000000000000
[   82.271638][ T1644] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.271639][ T1644] CR2: 00005571b074b010 CR3: 000000407c86c002 CR4: 0000000000f73ef0
[   82.278092][ T2471] 
[   82.284445][ T1644] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   82.287603][ T2471] /opt/deb/libpython3.11-minimal_3.11.2-6+deb12u5_amd64.deb
[   82.292478][ T1644] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   82.297171][ T2471] 
[   82.303411][ T1644] PKRU: 55555554
[   82.309646][ T2471] /opt/deb/python3.11-minimal_3.11.2-6+deb12u5_amd64.deb
[   82.311642][ T1644] Kernel panic - not syncing: Fatal exception
[   82.316193][ T1644] Kernel Offset: disabled



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



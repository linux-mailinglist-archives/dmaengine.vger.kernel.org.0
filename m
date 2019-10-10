Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E79D27F8
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2019 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfJJLbt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Oct 2019 07:31:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJLbt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Oct 2019 07:31:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ABTRun106466;
        Thu, 10 Oct 2019 11:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=p9WbR0dM77WKACvOXHaAs6Uq3LQwLedHdNpHjAHMW8A=;
 b=p9Wy5RieNe/GN/fEG+J4DAt8eFi9Zim3eaUJS0Mh9TzeFuhfPtaj0naj57FJkEl3npZY
 Su+yziOblZPOTH0UFed4YHxVSppZLI7RqKBqyhIBMl0jbmYfPiVlufFYayQmIKh18wP1
 1D3F6fGjybOFDMdNP0P0mzFos2401ntNhdpUzr7a78yHWz1NUCqIBUYsTUUdCBNrZR1O
 ERHGVL5rpIsRksinOM1DKSabsvHNnvdTYjrXkRG5xStc6W4K8tvt0hQ9UQXOsO9dYmbQ
 A6akrOj2duAHzuBtOD8DnNz5bvLx11jTFBxoFqyeXpsMmUlOlStlj+8bU1+5EhLsCfvo sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkutg37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 11:30:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ABRp3x054573;
        Thu, 10 Oct 2019 11:30:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vhrxdj78u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 11:30:43 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9ABUfns026696;
        Thu, 10 Oct 2019 11:30:42 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 04:30:40 -0700
Date:   Thu, 10 Oct 2019 14:30:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191010113034.GN13286@kadam>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191009121441.GM25098@kadam>
 <20191009145811.GA3823@AlexGordeev-DPT-VI0092>
 <20191009185323.GG13286@kadam>
 <20191010085144.GA14197@AlexGordeev-DPT-VI0092>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010085144.GA14197@AlexGordeev-DPT-VI0092>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100106
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Oct 10, 2019 at 10:51:45AM +0200, Alexander Gordeev wrote:
> On Wed, Oct 09, 2019 at 09:53:23PM +0300, Dan Carpenter wrote:
> > > > > +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> > > > > +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
> > > > > +	struct avalon_dma_desc *desc;
> > > > > +	struct virt_dma_desc *vdesc;
> > > > > +	bool rd_done;
> > > > > +	bool wr_done;
> > > > > +
> > > > > +	spin_lock(lock);
> > > > > +
> > > > > +	rd_done = (hw->h2d_last_id < 0);
> > > > > +	wr_done = (hw->d2h_last_id < 0);
> > > > > +
> > > > > +	if (rd_done && wr_done) {
> > > > > +		spin_unlock(lock);
> > > > > +		return IRQ_NONE;
> > > > > +	}
> > > > > +
> > > > > +	do {
> > > > > +		if (!rd_done && rd_flags[hw->h2d_last_id])
> > > > > +			rd_done = true;
> > > > > +
> > > > > +		if (!wr_done && wr_flags[hw->d2h_last_id])
> > > > > +			wr_done = true;
> > > > > +	} while (!rd_done || !wr_done);
> > > > 
> > > > This loop is very strange.  It feels like the last_id indexes needs
> > > > to atomic or protected from racing somehow so we don't do an out of
> > > > bounds read.
> 
> [...]
> 
> > You're missing my point.  When we set
> > hw->d2h_last_id = 1;
> [1]
> > ...
> > hw->d2h_last_id = 2;
> [2]
> 
> > There is a tiny moment where ->d2h_last_id is transitioning from 1 to 2
> > where its value is unknown.  We're in a busy loop here so we have a
> > decent chance of hitting that 1/1000,000th of a second.  If we happen to
> > hit it at exactly the right time then we're reading from a random
> > address and it will cause an oops.
> > 
> > We have to use atomic_t types or something to handle race conditions.
> 
> Err.. I am still missing the point :( In your example I do see a chance
> for a reader to read out 1 at point in time [2] - because of SMP race.
> But what could it be other than 1 or 2?
> 

The 1 to 2 transition was a poorly chosen example, but a -1 to 1
trasition is better.  The cpu could write a byte at a time.  So maybe
it only wrote the two highest bytes so now it's 0xffff.  It's not -1 and
it's not 1 and it's not a valid index.

> Anyways, all code paths dealing with h2d_last_id and d2h_last_id indexes
> are protected with a spinlock.

You have to protect both the writer and the reader.  (That's why this
bug is so easy to spot).  https://lwn.net/Articles/793253/

regards,
dan carpenter


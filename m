Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BD930A4F7
	for <lists+dmaengine@lfdr.de>; Mon,  1 Feb 2021 11:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhBAKHK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Feb 2021 05:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhBAKG5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Feb 2021 05:06:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78C2160295;
        Mon,  1 Feb 2021 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612173975;
        bh=t9DakzkwsbpXFu1GoSXgcUwejWe6O6oWwCg7qTxMxdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGohTz9+q7ZaZbbqW5+HMlU8Fdf+n1vFKDueDR0kPV1qUNMA0M00q55vkXvZvDGi5
         GW3pT8KFYzJWKjfUIOWtOwxY9+HKZs7ZLaDr0ImPDMey0i94ABSMArnkDW2EQm17lg
         euZfOKDs8kdK4U4dm7IDDo4PtxuGVQQ9R/vCGaZNoqmU2v6GwZcoazizrZvsbZ1kJB
         T85i0KexeYxj3D35/2H/XfBHEBl0Dm5+ZdS9WewyZ283iDYyyt6Y1JvqBop9ZVcRqS
         B59JhmXZ+XDwyJv9iFpGkYEGrEPzkvPotWlvuCNPYWmHtCkh7DLJLdZMGPtn5a7jNn
         d+eRTvaI8exdw==
Date:   Mon, 1 Feb 2021 15:36:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guanhua Gao <guanhua.gao@nxp.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: fsl-dpaa2-qdma: Update DPDMAI interfaces
Message-ID: <20210201100610.GR2771@vkoul-mobl>
References: <20201217092350.12427-1-guanhua.gao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217092350.12427-1-guanhua.gao@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-12-20, 17:23, Guanhua Gao wrote:
> This patch dupdates the DPDMAI interfaces to support MC firmware to
> 10.1x.x.

Threading is broken in this series, they do not appear together for me..

Can you explain what it means to support 10.1x.x...?

> 
> Signed-off-by: Guanhua Gao <guanhua.gao@nxp.com>
> ---
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c |  37 ++-----
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |   5 +-
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.c     | 174 ++++++++++++++++++--------------
>  drivers/dma/fsl-dpaa2-qdma/dpdmai.h     | 164 ++++++++++++++++++++++--------
>  4 files changed, 232 insertions(+), 148 deletions(-)
> 
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> index bc5baa6..73c694e 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -308,7 +308,6 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  	struct dpaa2_qdma_priv_per_prio *ppriv;
>  	struct device *dev = &ls_dev->dev;
>  	struct dpaa2_qdma_priv *priv;
> -	u8 prio_def = DPDMAI_PRIO_NUM;
>  	int err = -EINVAL;
>  	int i;
>  
> @@ -333,25 +332,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  		goto exit;
>  	}
>  
> -	if (priv->dpdmai_attr.version.major > DPDMAI_VER_MAJOR) {
> -		dev_err(dev, "DPDMAI major version mismatch\n"
> -			     "Found %u.%u, supported version is %u.%u\n",
> -				priv->dpdmai_attr.version.major,
> -				priv->dpdmai_attr.version.minor,
> -				DPDMAI_VER_MAJOR, DPDMAI_VER_MINOR);
> -		goto exit;
> -	}
> -
> -	if (priv->dpdmai_attr.version.minor > DPDMAI_VER_MINOR) {
> -		dev_err(dev, "DPDMAI minor version mismatch\n"
> -			     "Found %u.%u, supported version is %u.%u\n",
> -				priv->dpdmai_attr.version.major,
> -				priv->dpdmai_attr.version.minor,
> -				DPDMAI_VER_MAJOR, DPDMAI_VER_MINOR);
> -		goto exit;
> -	}
> -
> -	priv->num_pairs = min(priv->dpdmai_attr.num_of_priorities, prio_def);
> +	priv->num_pairs = priv->dpdmai_attr.num_of_queues;
>  	ppriv = kcalloc(priv->num_pairs, sizeof(*ppriv), GFP_KERNEL);
>  	if (!ppriv) {
>  		err = -ENOMEM;
> @@ -361,7 +342,7 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  
>  	for (i = 0; i < priv->num_pairs; i++) {
>  		err = dpdmai_get_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  i, &priv->rx_queue_attr[i]);
> +					  i, 0, &priv->rx_queue_attr[i]);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
>  			goto exit;
> @@ -369,13 +350,13 @@ static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
>  		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
>  
>  		err = dpdmai_get_tx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  i, &priv->tx_fqid[i]);
> +					  i, 0, &priv->tx_queue_attr[i]);
>  		if (err) {
>  			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
>  			goto exit;
>  		}
> -		ppriv->req_fqid = priv->tx_fqid[i];
> -		ppriv->prio = i;
> +		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
> +		ppriv->prio = DPAA2_QDMA_DEFAULT_PRIORITY;
>  		ppriv->priv = priv;
>  		ppriv++;
>  	}
> @@ -540,8 +521,7 @@ static int __cold dpaa2_dpdmai_bind(struct dpaa2_qdma_priv *priv)
>  		rx_queue_cfg.dest_cfg.dest_id = ppriv->nctx.dpio_id;
>  		rx_queue_cfg.dest_cfg.priority = ppriv->prio;
>  		err = dpdmai_set_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
> -					  rx_queue_cfg.dest_cfg.priority,
> -					  &rx_queue_cfg);
> +					  i, 0, &rx_queue_cfg);
>  		if (err) {
>  			dev_err(dev, "dpdmai_set_rx_queue() failed\n");
>  			return err;
> @@ -634,14 +614,13 @@ static int dpaa2_dpdmai_init_channels(struct dpaa2_qdma_engine *dpaa2_qdma)
>  {
>  	struct dpaa2_qdma_priv *priv = dpaa2_qdma->priv;
>  	struct dpaa2_qdma_chan *dpaa2_chan;
> -	int num = priv->num_pairs;
>  	int i;
>  
>  	INIT_LIST_HEAD(&dpaa2_qdma->dma_dev.channels);
>  	for (i = 0; i < dpaa2_qdma->n_chans; i++) {
>  		dpaa2_chan = &dpaa2_qdma->chans[i];
>  		dpaa2_chan->qdma = dpaa2_qdma;
> -		dpaa2_chan->fqid = priv->tx_fqid[i % num];
> +		dpaa2_chan->fqid = priv->tx_queue_attr[i].fqid;
>  		dpaa2_chan->vchan.desc_free = dpaa2_qdma_free_desc;
>  		vchan_init(&dpaa2_chan->vchan, &dpaa2_qdma->dma_dev);
>  		spin_lock_init(&dpaa2_chan->queue_lock);
> @@ -803,7 +782,7 @@ static void dpaa2_qdma_shutdown(struct fsl_mc_device *ls_dev)
>  	dpdmai_disable(priv->mc_io, 0, ls_dev->mc_handle);
>  	dpaa2_dpdmai_dpio_unbind(priv);
>  	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
> -	dpdmai_destroy(priv->mc_io, 0, ls_dev->mc_handle);
> +	dpdmai_destroy(priv->mc_io, 0, priv->dpqdma_id, ls_dev->mc_handle);
>  }
>  
>  static const struct fsl_mc_device_id dpaa2_qdma_id_table[] = {
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> index 7d57184..c04a3db 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> @@ -6,6 +6,7 @@
>  
>  #define DPAA2_QDMA_STORE_SIZE 16
>  #define NUM_CH 8
> +#define DPAA2_QDMA_DEFAULT_PRIORITY 0
>  
>  struct dpaa2_qdma_sd_d {
>  	u32 rsv:32;
> @@ -122,8 +123,8 @@ struct dpaa2_qdma_priv {
>  	struct dpaa2_qdma_engine	*dpaa2_qdma;
>  	struct dpaa2_qdma_priv_per_prio	*ppriv;
>  
> -	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_PRIO_NUM];
> -	u32 tx_fqid[DPDMAI_PRIO_NUM];
> +	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
> +	struct dpdmai_tx_queue_attr tx_queue_attr[DPDMAI_MAX_QUEUE_NUM];
>  };
>  
>  struct dpaa2_qdma_priv_per_prio {
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> index 878662a..e9bb47b 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
> @@ -7,47 +7,6 @@
>  #include <linux/fsl/mc.h>
>  #include "dpdmai.h"
>  
> -struct dpdmai_rsp_get_attributes {
> -	__le32 id;
> -	u8 num_of_priorities;
> -	u8 pad0[3];
> -	__le16 major;
> -	__le16 minor;
> -};
> -
> -struct dpdmai_cmd_queue {
> -	__le32 dest_id;
> -	u8 priority;
> -	u8 queue;
> -	u8 dest_type;
> -	u8 pad;
> -	__le64 user_ctx;
> -	union {
> -		__le32 options;
> -		__le32 fqid;
> -	};
> -};
> -
> -struct dpdmai_rsp_get_tx_queue {
> -	__le64 pad;
> -	__le32 fqid;
> -};
> -
> -#define MC_CMD_OP(_cmd, _param, _offset, _width, _type, _arg) \
> -	((_cmd).params[_param] |= mc_enc((_offset), (_width), _arg))
> -
> -/* cmd, param, offset, width, type, arg_name */
> -#define DPDMAI_CMD_CREATE(cmd, cfg) \
> -do { \
> -	MC_CMD_OP(cmd, 0, 8,  8,  u8,  (cfg)->priorities[0]);\
> -	MC_CMD_OP(cmd, 0, 16, 8,  u8,  (cfg)->priorities[1]);\
> -} while (0)
> -
> -static inline u64 mc_enc(int lsoffset, int width, u64 val)
> -{
> -	return (val & MAKE_UMASK64(width)) << lsoffset;
> -}
> -
>  /**
>   * dpdmai_open() - Open a control session for the specified object
>   * @mc_io:	Pointer to MC portal's I/O object
> @@ -68,16 +27,16 @@ static inline u64 mc_enc(int lsoffset, int width, u64 val)
>  int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  		int dpdmai_id, u16 *token)
>  {
> +	struct dpdmai_cmd_open *cmd_params;
>  	struct fsl_mc_command cmd = { 0 };
> -	__le64 *cmd_dpdmai_id;
>  	int err;
>  
>  	/* prepare command */
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_OPEN,
>  					  cmd_flags, 0);
>  
> -	cmd_dpdmai_id = cmd.params;
> -	*cmd_dpdmai_id = cpu_to_le32(dpdmai_id);
> +	cmd_params = (struct dpdmai_cmd_open *)cmd.params;
> +	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> @@ -138,15 +97,20 @@ EXPORT_SYMBOL_GPL(dpdmai_close);
>   * Return:	'0' on Success; Error code otherwise.
>   */
>  int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
> -		  const struct dpdmai_cfg *cfg, u16 *token)
> +		  const struct dpdmai_cfg *cfg, u16 token,
> +		  u32 *dpdmai_id)
>  {
> +	struct dpdmai_cmd_create *cmd_params;
>  	struct fsl_mc_command cmd = { 0 };
>  	int err;
>  
>  	/* prepare command */
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CREATE,
> -					  cmd_flags, 0);
> -	DPDMAI_CMD_CREATE(cmd, cfg);
> +					  cmd_flags, token);
> +	cmd_params = (struct dpdmai_cmd_create *)cmd.params;
> +	cmd_params->num_queues = cfg->num_queues;
> +	cmd_params->priorities[0] = cfg->priorities[0];
> +	cmd_params->priorities[1] = cfg->priorities[1];
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> @@ -154,26 +118,38 @@ int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  		return err;
>  
>  	/* retrieve response parameters */
> -	*token = mc_cmd_hdr_read_token(&cmd);
> +	*dpdmai_id = mc_cmd_read_object_id(&cmd);
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dpdmai_create);
>  
>  /**
>   * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
> - * @mc_io:      Pointer to MC portal's I/O object
> - * @cmd_flags:  Command flags; one or more of 'MC_CMD_FLAG_'
> - * @token:      Token of DPDMAI object
> + * @mc_io:	Pointer to MC portal's I/O object
> + * @token:	Parent container token; '0' for default container
> + * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
> + * @object_id:	The object id; it must be a valid id within the container that
> + *		created this object;
>   *
> - * Return:      '0' on Success; error code otherwise.
> + * The function accepts the authentication token of the parent container that
> + * created the object (not the one that currently owns the object). The object
> + * is searched within parent using the provided 'object_id'.
> + * All tokens to the object must be closed before calling destroy.
> + *
> + * Return:	'0' on Success; error code otherwise.
>   */
> -int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
> +int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		   u32 dpdmai_id, u16 token)
>  {
> +	struct dpdmai_cmd_destroy *cmd_params;
>  	struct fsl_mc_command cmd = { 0 };
>  
>  	/* prepare command */
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
>  					  cmd_flags, token);
> +	cmd_params = (struct dpdmai_cmd_destroy *)cmd.params;
> +	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
>  
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
> @@ -223,6 +199,40 @@ int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
>  EXPORT_SYMBOL_GPL(dpdmai_disable);
>  
>  /**
> + * dpdmai_is_enabled() - Check if the DPDMAI is enabled.
> + * @mc_io:	Pointer to MC portal's I/O object
> + * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
> + * @token:	Token of DPDMAI object
> + * @en:		Returns '1' if object is enabled; '0' otherwise
> + *
> + * Return:	'0' on Success; Error code otherwise.
> + */
> +int dpdmai_is_enabled(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		      u16 token, int *en)
> +{
> +	struct dpdmai_rsp_is_enabled *rsp_params;
> +	struct fsl_mc_command cmd = { 0 };
> +	int err;
> +
> +	/* prepare command */
> +	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_IS_ENABLED,
> +					  cmd_flags,
> +					  token);
> +
> +	/* send command to mc*/
> +	err = mc_send_command(mc_io, &cmd);
> +	if (err)
> +		return err;
> +
> +	/* retrieve response parameters */
> +	rsp_params = (struct dpdmai_rsp_is_enabled *)cmd.params;
> +	*en = dpdmai_get_field(rsp_params->en, ENABLE);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dpdmai_is_enabled);
> +
> +/**
>   * dpdmai_reset() - Reset the DPDMAI, returns the object to initial state.
>   * @mc_io:	Pointer to MC portal's I/O object
>   * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
> @@ -271,9 +281,8 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  	/* retrieve response parameters */
>  	rsp_params = (struct dpdmai_rsp_get_attributes *)cmd.params;
>  	attr->id = le32_to_cpu(rsp_params->id);
> -	attr->version.major = le16_to_cpu(rsp_params->major);
> -	attr->version.minor = le16_to_cpu(rsp_params->minor);
>  	attr->num_of_priorities = rsp_params->num_of_priorities;
> +	attr->num_of_queues = rsp_params->num_of_queues;
>  
>  	return 0;
>  }
> @@ -290,23 +299,27 @@ EXPORT_SYMBOL_GPL(dpdmai_get_attributes);
>   *
>   * Return:	'0' on Success; Error code otherwise.
>   */
> -int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> -			u8 priority, const struct dpdmai_rx_queue_cfg *cfg)
> +int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +			u16 token, u8 queue_idx, u8 priority,
> +			const struct dpdmai_rx_queue_cfg *cfg)
>  {
> -	struct dpdmai_cmd_queue *cmd_params;
> +	struct dpdmai_cmd_set_rx_queue *cmd_params;
>  	struct fsl_mc_command cmd = { 0 };
>  
>  	/* prepare command */
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_RX_QUEUE,
>  					  cmd_flags, token);
>  
> -	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
> +	cmd_params = (struct dpdmai_cmd_set_rx_queue *)cmd.params;
>  	cmd_params->dest_id = cpu_to_le32(cfg->dest_cfg.dest_id);
> -	cmd_params->priority = cfg->dest_cfg.priority;
> -	cmd_params->queue = priority;
> -	cmd_params->dest_type = cfg->dest_cfg.dest_type;
> +	cmd_params->dest_priority = cfg->dest_cfg.priority;
> +	cmd_params->priority = priority;
> +	cmd_params->queue_idx = queue_idx;
>  	cmd_params->user_ctx = cpu_to_le64(cfg->user_ctx);
>  	cmd_params->options = cpu_to_le32(cfg->options);
> +	dpdmai_set_field(cmd_params->dest_type,
> +			 DEST_TYPE,
> +			 cfg->dest_cfg.dest_type);
>  
>  	/* send command to mc*/
>  	return mc_send_command(mc_io, &cmd);
> @@ -324,10 +337,12 @@ EXPORT_SYMBOL_GPL(dpdmai_set_rx_queue);
>   *
>   * Return:	'0' on Success; Error code otherwise.
>   */
> -int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> -			u8 priority, struct dpdmai_rx_queue_attr *attr)
> +int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +			u16 token, u8 queue_idx, u8 priority,
> +			struct dpdmai_rx_queue_attr *attr)
>  {
> -	struct dpdmai_cmd_queue *cmd_params;
> +	struct dpdmai_cmd_get_queue *cmd_params;
> +	struct dpdmai_rsp_get_rx_queue *rsp_params;
>  	struct fsl_mc_command cmd = { 0 };
>  	int err;
>  
> @@ -335,8 +350,9 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_RX_QUEUE,
>  					  cmd_flags, token);
>  
> -	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
> -	cmd_params->queue = priority;
> +	cmd_params = (struct dpdmai_cmd_get_queue *)cmd.params;
> +	cmd_params->priority = priority;
> +	cmd_params->queue_idx = queue_idx;
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> @@ -344,11 +360,13 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
>  		return err;
>  
>  	/* retrieve response parameters */
> -	attr->dest_cfg.dest_id = le32_to_cpu(cmd_params->dest_id);
> -	attr->dest_cfg.priority = cmd_params->priority;
> -	attr->dest_cfg.dest_type = cmd_params->dest_type;
> -	attr->user_ctx = le64_to_cpu(cmd_params->user_ctx);
> -	attr->fqid = le32_to_cpu(cmd_params->fqid);
> +	rsp_params = (struct dpdmai_rsp_get_rx_queue *)cmd.params;
> +	attr->user_ctx = le64_to_cpu(rsp_params->user_ctx);
> +	attr->fqid = le32_to_cpu(rsp_params->fqid);
> +	attr->dest_cfg.dest_id = le32_to_cpu(rsp_params->dest_id);
> +	attr->dest_cfg.priority = le32_to_cpu(rsp_params->dest_priority);
> +	attr->dest_cfg.dest_type = dpdmai_get_field(rsp_params->dest_type,
> +						    DEST_TYPE);
>  
>  	return 0;
>  }
> @@ -366,10 +384,11 @@ EXPORT_SYMBOL_GPL(dpdmai_get_rx_queue);
>   * Return:	'0' on Success; Error code otherwise.
>   */
>  int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> -			u16 token, u8 priority, u32 *fqid)
> +			u16 token, u8 queue_idx, u8 priority,
> +			struct dpdmai_tx_queue_attr *attr)
>  {
> +	struct dpdmai_cmd_get_queue *cmd_params;
>  	struct dpdmai_rsp_get_tx_queue *rsp_params;
> -	struct dpdmai_cmd_queue *cmd_params;
>  	struct fsl_mc_command cmd = { 0 };
>  	int err;
>  
> @@ -377,8 +396,9 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_TX_QUEUE,
>  					  cmd_flags, token);
>  
> -	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
> -	cmd_params->queue = priority;
> +	cmd_params = (struct dpdmai_cmd_get_queue *)cmd.params;
> +	cmd_params->priority = priority;
> +	cmd_params->queue_idx = queue_idx;
>  
>  	/* send command to mc*/
>  	err = mc_send_command(mc_io, &cmd);
> @@ -388,7 +408,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  	/* retrieve response parameters */
>  
>  	rsp_params = (struct dpdmai_rsp_get_tx_queue *)cmd.params;
> -	*fqid = le32_to_cpu(rsp_params->fqid);
> +	attr->fqid = le32_to_cpu(rsp_params->fqid);
>  
>  	return 0;
>  }
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> index b13b9bf..bfa3aa9 100644
> --- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.h
> @@ -5,39 +5,41 @@
>  #define __FSL_DPDMAI_H
>  
>  /* DPDMAI Version */
> -#define DPDMAI_VER_MAJOR	2
> -#define DPDMAI_VER_MINOR	2
> +#define DPDMAI_VER_MAJOR	3
> +#define DPDMAI_VER_MINOR	3
>  
> -#define DPDMAI_CMD_BASE_VERSION	0
> +#define DPDMAI_CMD_BASE_VERSION	1
> +#define DPDMAI_CMD_VERSION_2	2
>  #define DPDMAI_CMD_ID_OFFSET	4
>  
> -#define DPDMAI_CMDID_FORMAT(x)	(((x) << DPDMAI_CMD_ID_OFFSET) | \
> -				DPDMAI_CMD_BASE_VERSION)
> +#define DPDMAI_CMD(id)		((id << DPDMAI_CMD_ID_OFFSET) | DPDMAI_CMD_BASE_VERSION)
> +#define DPDMAI_CMD_V2(id)	((id << DPDMAI_CMD_ID_OFFSET) | DPDMAI_CMD_VERSION_2)
>  
>  /* Command IDs */
> -#define DPDMAI_CMDID_CLOSE		DPDMAI_CMDID_FORMAT(0x800)
> -#define DPDMAI_CMDID_OPEN               DPDMAI_CMDID_FORMAT(0x80E)
> -#define DPDMAI_CMDID_CREATE             DPDMAI_CMDID_FORMAT(0x90E)
> -#define DPDMAI_CMDID_DESTROY            DPDMAI_CMDID_FORMAT(0x900)
> -
> -#define DPDMAI_CMDID_ENABLE             DPDMAI_CMDID_FORMAT(0x002)
> -#define DPDMAI_CMDID_DISABLE            DPDMAI_CMDID_FORMAT(0x003)
> -#define DPDMAI_CMDID_GET_ATTR           DPDMAI_CMDID_FORMAT(0x004)
> -#define DPDMAI_CMDID_RESET              DPDMAI_CMDID_FORMAT(0x005)
> -#define DPDMAI_CMDID_IS_ENABLED         DPDMAI_CMDID_FORMAT(0x006)
> -
> -#define DPDMAI_CMDID_SET_IRQ            DPDMAI_CMDID_FORMAT(0x010)
> -#define DPDMAI_CMDID_GET_IRQ            DPDMAI_CMDID_FORMAT(0x011)
> -#define DPDMAI_CMDID_SET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x012)
> -#define DPDMAI_CMDID_GET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x013)
> -#define DPDMAI_CMDID_SET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x014)
> -#define DPDMAI_CMDID_GET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x015)
> -#define DPDMAI_CMDID_GET_IRQ_STATUS     DPDMAI_CMDID_FORMAT(0x016)
> -#define DPDMAI_CMDID_CLEAR_IRQ_STATUS	DPDMAI_CMDID_FORMAT(0x017)
> -
> -#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT(0x1A0)
> -#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A1)
> -#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A2)
> +#define DPDMAI_CMDID_CLOSE		DPDMAI_CMD(0x800)
> +#define DPDMAI_CMDID_OPEN               DPDMAI_CMD(0x80E)
> +#define DPDMAI_CMDID_CREATE             DPDMAI_CMD_V2(0x90E)
> +#define DPDMAI_CMDID_DESTROY            DPDMAI_CMD(0x98E)
> +#define DPDMAI_CMDID_GET_API_VERSION	DPDMAI_CMD(0xa0E)
> +
> +#define DPDMAI_CMDID_ENABLE             DPDMAI_CMD(0x002)
> +#define DPDMAI_CMDID_DISABLE            DPDMAI_CMD(0x003)
> +#define DPDMAI_CMDID_GET_ATTR           DPDMAI_CMD_V2(0x004)
> +#define DPDMAI_CMDID_RESET              DPDMAI_CMD(0x005)
> +#define DPDMAI_CMDID_IS_ENABLED		DPDMAI_CMD(0x006)
> +
> +#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMD_V2(0x1A0)
> +#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMD_V2(0x1A1)
> +#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMD_V2(0x1A2)
> +
> +/* Macros for accessing command fields smaller than 1byte */
> +#define DPDMAI_MASK(field)	\
> +	GENMASK(DPDMAI_##field##_SHIFT + DPDMAI_##field##_SIZE - 1,	\
> +		DPDMAI_##field##_SHIFT)
> +#define dpdmai_set_field(var, field, val)	\
> +	((var) |= (((val) << DPDMAI_##field##_SHIFT) & DPDMAI_MASK(field)))
> +#define dpdmai_get_field(var, field)	\
> +	(((var) & DPDMAI_MASK(field)) >> DPDMAI_##field##_SHIFT)
>  
>  #define MC_CMD_HDR_TOKEN_O 32  /* Token field offset */
>  #define MC_CMD_HDR_TOKEN_S 16  /* Token field size */
> @@ -49,11 +51,21 @@
>   * Contains initialization APIs and runtime control APIs for DPDMAI
>   */
>  
> +/*
> + * Maximum number of Tx/Rx queues per DPDMAI object
> + */
> +#define DPDMAI_MAX_QUEUE_NUM	8
> +
>  /**
>   * Maximum number of Tx/Rx priorities per DPDMAI object
>   */
>  #define DPDMAI_PRIO_NUM		2
>  
> +/**
> + * All queues considered; see dpdmai_set_rx_queue()
> + */
> +#define DPDMAI_ALL_QUEUES	((uint8_t)(-1))
> +
>  /* DPDMAI queue modification options */
>  
>  /**
> @@ -66,6 +78,69 @@
>   */
>  #define DPDMAI_QUEUE_OPT_DEST		0x2
>  
> +struct dpdmai_cmd_open {
> +	u32	dpdmai_id;
> +};
> +
> +struct dpdmai_cmd_create {
> +	u8	num_queues;
> +	u8	priorities[2];
> +};
> +
> +struct dpdmai_cmd_destroy {
> +	u32	dpdmai_id;
> +};
> +
> +#define DPDMAI_ENABLE_SHIFT	0
> +#define DPDMAI_ENABLE_SIZE	1
> +
> +struct dpdmai_rsp_is_enabled {
> +	/* only the LSB bit */
> +	u8 en;
> +};
> +
> +struct dpdmai_rsp_get_attributes {
> +	u32 id;
> +	u8 num_of_priorities;
> +	u8 num_of_queues;
> +};
> +
> +#define DPDMAI_DEST_TYPE_SHIFT	0
> +#define DPDMAI_DEST_TYPE_SIZE	4
> +
> +struct dpdmai_cmd_set_rx_queue {
> +	u32 dest_id;
> +	u8 dest_priority;
> +	u8 priority;
> +	/* from LSB: dest_type:4 */
> +	u8 dest_type;
> +	u8 queue_idx;
> +	u64 user_ctx;
> +	u32 options;
> +};
> +
> +struct dpdmai_cmd_get_queue {
> +	u8 pad[5];
> +	u8 priority;
> +	u8 queue_idx;
> +};
> +
> +struct dpdmai_rsp_get_rx_queue {
> +	u32 dest_id;
> +	u8 dest_priority;
> +	u8 pad1;
> +	/* from LSB: dest_type:4 */
> +	u8 dest_type;
> +	u8 pad2;
> +	u64 user_ctx;
> +	u32 fqid;
> +};
> +
> +struct dpdmai_rsp_get_tx_queue {
> +	u64 pad;
> +	u32 fqid;
> +};
> +
>  /**
>   * struct dpdmai_cfg - Structure representing DPDMAI configuration
>   * @priorities: Priorities for the DMA hardware processing; valid priorities are
> @@ -73,6 +148,7 @@
>   *	should be configured with 0
>   */
>  struct dpdmai_cfg {
> +	u8 num_queues;
>  	u8 priorities[DPDMAI_PRIO_NUM];
>  };
>  
> @@ -83,17 +159,14 @@ struct dpdmai_cfg {
>   * @num_of_priorities: number of priorities
>   */
>  struct dpdmai_attr {
> -	int	id;
> +	int id;
>  	/**
>  	 * struct version - DPDMAI version
>  	 * @major: DPDMAI major version
>  	 * @minor: DPDMAI minor version
>  	 */
> -	struct {
> -		u16 major;
> -		u16 minor;
> -	} version;
>  	u8 num_of_priorities;
> +	u8 num_of_queues;
>  };
>  
>  /**
> @@ -158,22 +231,33 @@ struct dpdmai_rx_queue_attr {
>  	u32 fqid;
>  };
>  
> +struct dpdmai_tx_queue_attr {
> +	u32 fqid;
> +};
> +
>  int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  		int dpdmai_id, u16 *token);
>  int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
> -int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
>  int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
> -		  const struct dpdmai_cfg *cfg, u16 *token);
> +		  const struct dpdmai_cfg *cfg, u16 token,
> +		  u32 *dpdmai_id);
> +int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		   u32 dpdmai_id, u16 token);
>  int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
>  int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
> +int dpdmai_is_enabled(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +		      u16 token, int *en);
>  int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
>  int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
>  			  u16 token, struct dpdmai_attr	*attr);
> -int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> -			u8 priority, const struct dpdmai_rx_queue_cfg *cfg);
> -int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
> -			u8 priority, struct dpdmai_rx_queue_attr *attr);
> +int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +			u16 token, u8 queue_idx, u8 priority,
> +			const struct dpdmai_rx_queue_cfg *cfg);
> +int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> +			u16 token, u8 queue_idx, u8 priority,
> +			struct dpdmai_rx_queue_attr *attr);
>  int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
> -			u16 token, u8 priority, u32 *fqid);
> +			u16 token, u8 queue_idx, u8 priority,
> +			struct dpdmai_tx_queue_attr *attr);
>  
>  #endif /* __FSL_DPDMAI_H */
> -- 
> 2.7.4

-- 
~Vinod
